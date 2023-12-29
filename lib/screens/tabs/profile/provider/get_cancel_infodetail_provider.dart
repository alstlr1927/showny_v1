import 'package:flutter/material.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/screens/tabs/profile/model/getcancle_info_detail_response_model.dart';

class GetCancelInfoDetailProvider extends ChangeNotifier{
  GetStoreCancelInfoDetailModel? _getStoreCancelInfoDetailModel;

  GetStoreCancelInfoDetailModel? get getStoreCancelInfoDetailModel =>
      _getStoreCancelInfoDetailModel;

  bool _isCancelInfoDetailLoading = true;

  bool getIsCancelInfoDetailLoading() => _isCancelInfoDetailLoading;

  setIsCancelInfoDetailLoading(bool value) {
    _isCancelInfoDetailLoading = value;
    notifyListeners();
  }

  getCancelInfoDetailData(String memNo, String orderNo) {
    if (!_isCancelInfoDetailLoading) {
      setIsCancelInfoDetailLoading(true);
    }
    ApiService().getCancelInfoDetailApi(memNo: memNo,orderNo: orderNo).then((getCancelInfoDetailSuccess) {
      if(getCancelInfoDetailSuccess!.success!){
        _getStoreCancelInfoDetailModel = getCancelInfoDetailSuccess;
        setIsCancelInfoDetailLoading(false);
        notifyListeners();
      }
    });
  }
}