import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/logger/showny_logger.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/styleup_battle_item_model.dart';
import '../../../../models/styleup_battle_model.dart';
import '../../../../providers/user_model_provider.dart';
import '../battle_screen.dart';

class BattleScreenProvider with ChangeNotifier {
  State<BattleScreen> state;

  StyleupBattleModel? styleUpBattle;

  void setBattleData(
      {required String roundNo, required StyleupBattleItemModel copy}) {
    int idx = styleUpBattle!.battleItemList
        .indexWhere((element) => element.battleRoundNo == roundNo);
    if (idx != -1) {
      styleUpBattle!.battleItemList[idx] = copy;
      notifyListeners();
    }
  }

  void getBattleItemList() {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    ShownyLog().e('call : getBattleItemList');
    ApiHelper.shared.getStyleupBattleItemList(
      userProvider.user.memNo,
      (styleupBattleModel) {
        ShownyLog().i("getBattleItemList success");
        styleUpBattle = styleupBattleModel;

        notifyListeners();
      },
      (error) {
        ShownyLog().e("error getBattleItemList : $error");
      },
    );
  }

  void getBattleItemListById(String battleNo) {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);

    ApiHelper.shared.getStyleupBattleItemListById(
      userProvider.user.memNo,
      battleNo,
      (styleupBattleModel) {
        ShownyLog().i("getBattleItemListById success : ${battleNo}");
        styleUpBattle = styleupBattleModel;

        notifyListeners();
      },
      (error) {
        ShownyLog().e("error getBattleItemListById : $error");
      },
    );
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

  BattleScreenProvider(this.state) {
    ShownyLog().e('?????????????????????????????????????');
    ShownyLog().e('battleno : ${state.widget.battleNo}');
    if (state.widget.battleNo.isNotEmpty) {
      // 다른 battleNo로 가져오기
      getBattleItemListById(state.widget.battleNo);
    } else {
      // home battle data 가져오기
      getBattleItemList();
    }
  }
}
