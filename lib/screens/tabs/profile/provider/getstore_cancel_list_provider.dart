import 'package:flutter/material.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/screens/tabs/profile/model/get_store_canclelist_response_model.dart';

class GetStoreCancelListProvider extends ChangeNotifier{
  GetStoreCancelListModel? _getStoreCancelListModel;

  GetStoreCancelListModel? get getStoreCancelListModel =>
      _getStoreCancelListModel;

  bool _isStoreCancelListLoading = true;

  bool getIsStoreCancelListLoading() => _isStoreCancelListLoading;

  setIsStoreCancelListLoading(bool value) {
    _isStoreCancelListLoading = value;
    notifyListeners();
  }

  getStoreCancelListData(String memNo) {
    if (!_isStoreCancelListLoading) {
      setIsStoreCancelListLoading(true);
    }
    ApiService().getStoreCancelListApi(memNo: memNo).then((getStoreCancelListSuccess) {
      if(getStoreCancelListSuccess!.success!){
        _getStoreCancelListModel = getStoreCancelListSuccess;
        setIsStoreCancelListLoading(false);
        notifyListeners();
      }
    });
  }
}