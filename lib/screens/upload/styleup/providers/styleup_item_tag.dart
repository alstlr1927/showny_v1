import 'package:flutter/material.dart';

class StyleupItemTagProvider with ChangeNotifier {
  State state;

  int imgIdx = 0;

  void imgIndexChange(int val) {
    imgIdx = val;
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

  StyleupItemTagProvider(this.state);
}
