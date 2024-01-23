import 'package:flutter/material.dart';

class StoreWrapperProvider with ChangeNotifier {
  State state;
  int currentIdx = 0;

  void setCurrentIdx(int val) {
    currentIdx = val;
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

  StoreWrapperProvider(this.state) {
    //
  }
}
