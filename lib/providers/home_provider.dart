import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/styleup_battle_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/home/screen/battle_screen.dart';
import 'package:showny/screens/tabs/home/screen/styleup_screen.dart';

class HomeProvider with ChangeNotifier {
  State state;

  int selectedMenuIdx = 0;
  late List<Widget> homeMenu;
  int currentBattle = 0;
  StyleupBattleModel? styleUpBattle;
  List<StyleupModel> styleUpList = [];

  var showTag = false;

  Widget get currentScreen => homeMenu[selectedMenuIdx];

  void setSelectedMenuIdx(int idx) {
    selectedMenuIdx = idx;
    notifyListeners();
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
