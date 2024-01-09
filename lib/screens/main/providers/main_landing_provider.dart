import 'package:flutter/material.dart';
import 'package:showny/screens/main/root_screen.dart';
import 'package:showny/screens/main/types/types.dart';

class MainLandingProvider with ChangeNotifier {
  final MainLandingState state;

  MainLandingType currentType = MainLandingType.home;

  void setPage({required MainLandingType type}) {
    currentType = type;
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

  MainLandingProvider(this.state) {
    //
  }
}
