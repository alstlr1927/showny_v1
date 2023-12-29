import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';

import '../api/new_api/api_service.dart';
import '../models/FetchGetMemberMinishopProductModel.dart';

class FetchGetMemberMinishopProductProvider extends ChangeNotifier{
  FetchGetMemberMinishopProductModel? _fetchGetMemberMinishopProductModel;
  int _status = 2;
  int get status => _status;

  FetchGetMemberMinishopProductModel? get fetchGetMemberMinishopProductModel =>
      _fetchGetMemberMinishopProductModel;

  bool _isStoreCartLoading = true;


  bool getIsStoreCartLoading() => _isStoreCartLoading;

  updateStatus(value,context){
    _status = value;
    getStoreCartListData(context);
    notifyListeners();
  }

  setIsStoreCartLoading(bool value) {
    _isStoreCartLoading = value;
    notifyListeners();
  }

  getStoreCartListData(BuildContext context) {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    if (!_isStoreCartLoading) {
      setIsStoreCartLoading(true);
    }
    ApiService().fetchGetMemberMinishopProduct(userProvider.user.memNo,"$_status","0").then((getStoreCartListSuccess) {
      if(getStoreCartListSuccess.success!){
        _fetchGetMemberMinishopProductModel = getStoreCartListSuccess;
        setIsStoreCartLoading(false);
        notifyListeners();
      }
    });


  }
}