import 'package:flutter/foundation.dart';
import 'package:showny/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  void updateUserInfo(UserModel userModel) {
    _user = userModel;
    notifyListeners();
  }
}