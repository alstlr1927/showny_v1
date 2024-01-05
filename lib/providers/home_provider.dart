import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/styleup_battle_item_model.dart';
import 'package:showny/models/styleup_battle_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/scroll_physics/custom_scroll_physics.dart';
import 'package:showny/screens/tabs/home/screen/battle_screen.dart';
import 'package:showny/screens/tabs/home/screen/styleup_screen.dart';

class HomeProvider with ChangeNotifier {
  State state;

  late List<Widget> homeMenu;
  int currentBattle = 0;
  StyleupBattleModel? styleUpBattle;
  List<StyleupModel> styleUpList = [];

  var showTag = false;

  /////////

  late PageController pageController;
  late TabController tabController;

  // Widget get currentScreen => homeMenu[selectedMenuIdx];

  int curPageIdx = 0;
  bool isBattleSelected = false;

  // void setSelectedMenuIdx(int idx) {
  //   selectedMenuIdx = idx;
  //   notifyListeners();
  // }

  ScrollPhysics getPhysics() {
    if (curPageIdx == 0 || isBattleSelected) {
      return const CustomScrollPhysics();
    }
    return const NeverScrollableScrollPhysics();
  }

  void setIsBattleSelected(bool value) {
    isBattleSelected = value;
    notifyListeners();
  }

  void setCurrentBattle(int idx) {
    currentBattle = idx;
    notifyListeners();
  }

  void setBattleData(
      {required String roundNo, required StyleupBattleItemModel copy}) {
    int idx = styleUpBattle!.battleItemList
        .indexWhere((element) => element.battleRoundNo == roundNo);
    if (idx != -1) {
      styleUpBattle!.battleItemList[idx] = copy;
      notifyListeners();
    }
  }

  // TODO 추후 copyWith 사용하여 styleup 데이터 수정하는 부분 통합
  void setStyleUpDown({required String styleUpNo, required int value}) {
    int idx =
        styleUpList.indexWhere((element) => element.styleupNo == styleUpNo);
    if (idx != -1) {
      styleUpList[idx].upDownType = value;
      notifyListeners();
    }
  }

  void setStyleUpFollow({required String styleUpNo, required bool value}) {
    int idx =
        styleUpList.indexWhere((element) => element.styleupNo == styleUpNo);

    if (idx != -1) {
      styleUpList[idx].userInfo.isFollow = value;
      notifyListeners();
    }
  }

  void setTab(int value) {
    tabController.animateTo(value,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    curPageIdx = value;
    notifyListeners();
  }

  void setpage(int value) {
    curPageIdx = value;
    notifyListeners();
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void getStyleUpList() {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    ApiHelper.shared.getStyleupList(
      userProvider.user.memNo,
      '0',
      (styleUpList) {
        debugPrint('StyleUp list loaded suceessfully');
        this.styleUpList = styleUpList;
        homeMenu[0] = StyleupScreen(
          initIndex: 0,
          styleupList: styleUpList,
          isMain: true,
        );
        notifyListeners();
      },
      (error) {
        debugPrint("Error loading styleup list: $error");
      },
    );
  }

  void getBattleItemList() {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);

    ApiHelper.shared.getStyleupBattleItemList(
      userProvider.user.memNo,
      (styleupBattleModel) {
        debugPrint("Battle list loaded successfully");
        styleUpBattle = styleupBattleModel;
        debugPrint(styleupBattleModel.battleItemList.length.toString());
        homeMenu[1] = BattleScreen(
          battleList: styleupBattleModel.battleItemList,
          onPageChanged: (p0) {
            currentBattle = p0;
            notifyListeners();
          },
          title: styleupBattleModel.title,
          battleRound: styleupBattleModel.round,
          isMain: true,
        );
        notifyListeners();
      },
      (error) {
        debugPrint("Error loading styleup list: $error");
      },
    );
  }

  void updateShowMenu(bool isShow) {
    debugPrint("updateShowMenu");
    showTag = isShow;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  HomeProvider(this.state) {
    pageController = PageController();
    tabController = TabController(length: 2, vsync: state as TickerProvider);
    homeMenu = [
      StyleupScreen(
        isMain: true,
        initIndex: 0,
        styleupList: styleUpList,
        updateShowMenu: updateShowMenu,
      ),
      BattleScreen(
        battleList: styleUpBattle?.battleItemList ?? [],
        onPageChanged: (p0) {
          currentBattle = p0;
          notifyListeners();
        },
        title: "",
        battleRound: "",
        isMain: true,
      ),
    ];
    getStyleUpList();
    getBattleItemList();
  }
}
