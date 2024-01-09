import 'package:flutter/material.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/screens/profile/model/get_myshopping_response_model.dart';
import 'package:showny/screens/profile/model/get_profile_response_model.dart';

class GetProfileProvider extends ChangeNotifier {
  GetMyShoppingResponseModel? _getMyShoppingResponseModel;
  GetProfileResponseModel? _getProfileResponseModel;

  GetMyShoppingResponseModel? get getMyShoppingResponseModel =>
      _getMyShoppingResponseModel;
  GetProfileResponseModel? get getProfileResponseModel =>
      _getProfileResponseModel;

  bool _isProfileLoading = true;
  bool _isShoppingLoading = true;

  bool getIsProfileLoading() => _isProfileLoading;
  bool getIsShoppingLoading() => _isShoppingLoading;

  setIsProfileLoading(bool value) {
    _isProfileLoading = value;
    notifyListeners();
  }

  setIsShoppingLoading(bool value) {
    _isShoppingLoading = value;
    notifyListeners();
  }

  getMyShoppingData(String memNo, String orderNo) {
    if (!_isShoppingLoading) {
      setIsShoppingLoading(true);
    }
    ApiService()
        .getMyShoppingApi(memNo: memNo, orderNo: orderNo)
        .then((getMyShoppingSuccess) {
      if (getMyShoppingSuccess!.success!) {
        _getMyShoppingResponseModel = getMyShoppingSuccess;
        setIsShoppingLoading(false);
        notifyListeners();
      }
    });
  }

  getProfileData(String memNo) {
    if (!_isProfileLoading) {
      setIsProfileLoading(true);
    }
    ApiService().getProfileApi(memNo: memNo).then((getProfileSuccess) {
      if (getProfileSuccess!.success!) {
        _getProfileResponseModel = getProfileSuccess;
        setIsProfileLoading(false);
        notifyListeners();
      }
    });
  }
}
