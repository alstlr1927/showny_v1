import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';

class GetMyProfileProvider extends ChangeNotifier {
  List<StyleupModel> myStyleupList = [];
  List<StyleupModel> myBookmarkList = [];

  int myStyleupListPage = 0;
  int myBookmarkListPage = 0;

  void getMyStyleupList(context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    ApiHelper.shared.getMyStyleupList(user.memNo, myStyleupListPage,
        (styleupModelList) {
      myStyleupList = List.from(myStyleupList)..addAll(styleupModelList);
      notifyListeners();
    }, (error) {});
  }

  void getMyBookmarkList(context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    ApiHelper.shared.getProfileStyleupList(user.memNo, 4, myBookmarkListPage,
        (styleupModelList) {
      myBookmarkList = List.from(myBookmarkList)..addAll(styleupModelList);
      notifyListeners();
    }, (error) {});
  }

  void removeMyStyleupList() {
    myStyleupListPage = 0;
    myStyleupList.clear();
  }

  void setStyleUpDown({required String styleUpNo, required int value}) {
    int idx =
        myStyleupList.indexWhere((element) => element.styleupNo == styleUpNo);
    if (idx != -1) {
      myStyleupList[idx].upDownType = value;
      notifyListeners();
    }
  }

  void setStyleUpFollow({required String styleUpNo, required bool value}) {
    int idx =
        myStyleupList.indexWhere((element) => element.styleupNo == styleUpNo);
    if (idx != -1) {
      myStyleupList[idx].userInfo.isFollow = value;
      notifyListeners();
    }
  }

  void removeMyBookmarkList() {
    myBookmarkListPage = 0;
    myBookmarkList.clear();
  }

  void getProfileData(context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    ApiHelper.shared.getProfile(user.memNo, user.memNo, (user) {
      debugPrint(user.memNo);
      userProvider.updateUserInfo(user);
      notifyListeners();
    }, (error) {});
  }
}
