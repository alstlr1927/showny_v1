import 'package:flutter/cupertino.dart';
import 'package:showny/main.dart';
import 'package:showny/models/store_good_model.dart';

import '../../../../api/new_api/api_helper.dart';

class StoreWishListProvider extends ChangeNotifier {
  List<StoreGoodModel> storeGoodsWishList = [];
  bool _isStoreWishListLoading = false;

  bool getIsStoreWishListLoading() => _isStoreWishListLoading;

  updateNotifyData() {
    notifyListeners();
  }

  setIsStoreWishListLoading(bool value) {
    _isStoreWishListLoading = value;
    notifyListeners();
  }

  getGoodsHeart(String memNo) {
    setIsStoreWishListLoading(true);
    ApiHelper.shared.getGoodsHeartList(memNo, (goodsWishList) {
      storeGoodsWishList = goodsWishList;
      setIsStoreWishListLoading(false);
      notifyListeners();
    }, (error) {
      setIsStoreWishListLoading(false);
      notifyListeners();
    });
  }
}
