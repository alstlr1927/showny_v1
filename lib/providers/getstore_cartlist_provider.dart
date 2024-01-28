import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/screens/profile/model/get_store_cart_list_response_model.dart'
    as products;

class GetStoreCartListProvider extends ChangeNotifier {
  List<products.Data> _productsList = [];

  bool _isStoreCartLoading = true;

  void increment(String goodsNo) {
    var product =
        _productsList.firstWhere((element) => element.goodsNo! == goodsNo);
    product.goodsCnt = (int.parse(product.goodsCnt!) + 1).toString();
    notifyListeners();
  }

  void decrement(String goodsNo) {
    var product =
        _productsList.firstWhere((element) => element.goodsNo! == goodsNo);
    if (int.parse(product.goodsCnt!) > 0) {
      product.goodsCnt = (int.parse(product.goodsCnt!) - 1).toString();
    }
    notifyListeners();
  }

  bool checkFalse() {
    int cnt = 0;
    for (var element in _productsList) {
      if (!(element.isSelected ?? false)) {
        cnt++;
      }
    }
    return cnt != _productsList.length;
  }

  remove(int index) {
    _productsList.removeAt(index);
    notifyListeners();
  }

  bool getCheckboxState(int index) {
    return _productsList[index].isSelected ?? false;
  }

  List<products.Data> getProducts() {
    return _productsList;
  }

  void toggleCheckbox(int index) {
    _productsList[index].isSelected =
        !(_productsList[index].isSelected ?? false);
    notifyListeners();
  }

  bool getIsStoreCartLoading() => _isStoreCartLoading;

  setIsStoreCartLoading(bool value) {
    _isStoreCartLoading = value;
    notifyListeners();
  }

  getStoreCartListData(String memNo, int page) {
    if (!_isStoreCartLoading) {
      setIsStoreCartLoading(true);
    }
    ApiService()
        .getStoreCartListApi(memNo: memNo, page: page)
        .then((getStoreCartListSuccess) {
      if (getStoreCartListSuccess!.success!) {
        _productsList = getStoreCartListSuccess!.data ?? [];
        setIsStoreCartLoading(false);
        notifyListeners();
      }
    });
  }
}
