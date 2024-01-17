import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/styleup_model.dart';

import '../../../../providers/user_model_provider.dart';

class SelectStyleupProvider with ChangeNotifier {
  State state;
  List<StyleupModel> styleupList = [];

  Future getAvaliableStyleupList() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;

    ApiHelper.shared.getAvailableBattleUploadStyleupList(user.memNo, '0',
        (styleupModelList) {
      styleupList = [...styleupModelList];
      notifyListeners();
    }, (error) {
      debugPrint('my styleup load failed: $error');
    });
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

  SelectStyleupProvider(this.state) {
    getAvaliableStyleupList();
  }
}
