import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/battle_model.dart';
import 'package:showny/providers/user_model_provider.dart';

class SelectBattleProvider with ChangeNotifier {
  State state;

  int _currentIdx = 0;
  int get currentIdx => _currentIdx;
  List<BattleModel> battleList = [];

  void onPageChanged(int index) {
    _currentIdx = index;
    notifyListeners();
  }

  Future getStyleupBattleList() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    ApiHelper.shared.getStyleupBattleList(
      user.memNo,
      '',
      0,
      5,
      (battles) {
        battleList = [...battles];
        print('battle length : ${battleList.length}');
        notifyListeners();
      },
      (error) {
        debugPrint('battle load failed');
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

  SelectBattleProvider(this.state) {
    getStyleupBattleList();
  }
}
