import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/entities/styleup_battle_response.dart';
import 'package:showny/components/logger/showny_logger.dart';

import '../../../api/new_api/api_helper.dart';
import '../../../models/styleup_battle_item_model.dart';
import '../../../models/styleup_battle_model.dart';
import '../../../providers/user_model_provider.dart';
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

    ApiHelper.shared.getStyleupBattleItemList(
      userProvider.user.memNo,
      (styleupBattleModel) {
        ShownyLog().i("Battle list loaded successfully");
        styleUpBattle = styleupBattleModel;

        notifyListeners();
      },
      (error) {
        debugPrint("Error loading styleup list: $error");
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
        ShownyLog().i("Battle list loaded successfully");
        styleUpBattle = styleupBattleModel;

        notifyListeners();
      },
      (error) {
        debugPrint("Error loading styleup list: $error");
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
    if (state.widget.battleNo.isNotEmpty) {
      // 다른 battleNo로 가져오기
      getBattleItemListById(state.widget.battleNo);
    } else {
      // home battle data 가져오기
      getBattleItemList();
    }
  }
}
