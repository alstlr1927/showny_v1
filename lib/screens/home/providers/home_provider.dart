import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';

class HomeProvider with ChangeNotifier {
  State state;

  List<StyleupModel> styleUpList = [];

  var showTag = false;

  late PageController pageController;
  late TabController tabController;

  int curPageIdx = 0;
  bool isBattleSelected = false;

  ScrollPhysics getPhysics() {
    if (curPageIdx == 0 || isBattleSelected) {
      return const ClampingScrollPhysics();
    }
    return const NeverScrollableScrollPhysics();
  }

  void setIsBattleSelected(bool value) {
    isBattleSelected = value;
    notifyListeners();
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

    getStyleUpList();
  }
}
