import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/utils/showny_style.dart';

import '../../../api/new_api/api_helper.dart';
import '../../../models/battle_model.dart';
import '../../../providers/user_model_provider.dart';
import '../../home/battle_screen.dart';

enum ListType {
  ongoing,
  total,
  voted,
  finished,
}

class BattleListProvider with ChangeNotifier {
  State state;
  late TabController tabController;

  ListType curType = ListType.ongoing;
  List<BattleModel> battleDataList = [];

  // sliderview index
  int sliderIdx = 0;

  bool isDataLoading = false;

  void _setDataLoad(bool flag) {
    isDataLoading = flag;
    notifyListeners();
  }

  void onSliderPageChanged(int idx) {
    sliderIdx = idx;
    notifyListeners();
  }

  void onTabChanged(int idx) {
    switch (idx) {
      case 0:
        curType = ListType.ongoing;
        sliderIdx = 0;
        _getStyleupBattleList(type: 2);
        break;
      case 1:
        curType = ListType.total;
        _getStyleupBattleList(type: 1);
        break;
      case 2:
        curType = ListType.voted;
        _getStyleupBattleList(type: 3);
        break;
      case 3:
        curType = ListType.finished;
        _getStyleupBattleList(type: 4);
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void _getStyleupBattleList({String keyword = '', required int type}) {
    // type 1 => 전체
    // type 2 => 진행중
    // type 3 => 투표한
    // type 4 => 종료된
    _setDataLoad(true);
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;

    ApiHelper.shared.getStyleupBattleList(
      user.memNo,
      keyword,
      0,
      type,
      (battleModelList) {
        // setState(() => battleDataList = battleModelList);
        ShownyLog().i('length : ${battleModelList.length}');
        battleDataList = [...battleModelList];
        _setDataLoad(false);
        ShownyLog().i('DEBUG: get styleup battle list succeed');
      },
      (error) {
        ShownyLog().e('DEBUG: get styleup battl list failed');
      },
    );
  }

  String battleStatusStringEn(String status) {
    if (status == '1') {
      return 'BATTLE ON';
    } else if (status == '3') {
      return 'VOTE ON';
    }
    return '';
  }

  Color battleStatusColor(String status) {
    if (status == '1') {
      return ShownyStyle.mainPurple;
    } else if (status == '3') {
      return ShownyStyle.mainRed;
    }
    return ShownyStyle.black;
  }

  void onClickItemButton(BattleModel battle) {
    if (battle.status == "0") {
    } else if (battle.status == "1") {
      //
    } else if (battle.status == "2") {
    } else if (battle.status == "3") {
      Navigator.push(
          state.context,
          ShownyPageRoute(
            builder: (context) => BattleScreen(
              isMain: false,
              battleNo: battle.styleupBattleNo,
            ),
          ));
    } else if (battle.status == "4") {}
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

  BattleListProvider(this.state) {
    tabController = TabController(length: 4, vsync: state as TickerProvider);
    _getStyleupBattleList(type: 2);
  }
}
