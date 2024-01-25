import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/models/store_good_model.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/get_storelist_response_model.dart';

class StoreProvider extends ChangeNotifier {
  final List<String> categories = [
    tr('mini_shop.category.outer'),
    tr('mini_shop.category.tops'),
    tr('mini_shop.category.bottoms'),
    tr('mini_shop.category.shoes'),
    tr('mini_shop.category.accessories'),
    tr('mini_shop.category.stuff'),
  ];

  GetStoreListResponseModel? _storeMainPageData;
  List<StoreGoodModel> battleInGoods = [];
  bool _isLoading = true;
  bool _isStoreMainDataLoading = true;
  int _indexTab = 0;

  updateNotifyData() {
    notifyListeners();
  }

  bool getIsLoading() => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  GetStoreListResponseModel? getStoreMainPageData() => _storeMainPageData;

  setStoreMainPageData(GetStoreListResponseModel value) {
    _storeMainPageData = value;
    notifyListeners();
  }

  bool getIsStoreMainDataLoading() => _isStoreMainDataLoading;

  setIsStoreMainDataLoading(bool value) {
    _isStoreMainDataLoading = value;
    notifyListeners();
  }

  int get indexTab => _indexTab;

  updateIndex(value) {
    _indexTab = value;
    notifyListeners();
  }

  List<StoreGoodModel> getBattleInGoods() => battleInGoods;

  getStoreMainPageDataApi(String memNo) {
    if (!getIsStoreMainDataLoading()) {
      setIsStoreMainDataLoading(true);
    }
    ApiService().getStoreMainListApi(memNo).then((getStoreListSuccess) {
      if (getStoreListSuccess!.success!) {
        setStoreMainPageData(getStoreListSuccess);
        setIsStoreMainDataLoading(false);
        notifyListeners();
      }
    });
  }

  getBattleInProductList(String memNo) {
    ApiHelper.shared.getBattleInProductList(memNo, (goodsList) {
      debugPrint(goodsList.toString());
      battleInGoods = goodsList;
      notifyListeners();
    }, (error) {});
  }

  bool _isMenSel = true;

  bool get isMenSel => _isMenSel;

  isSelectedListItem() {
    notifyListeners();
  }

  getIsMenSel(value) {
    _isMenSel = value;
    notifyListeners();
  }
}
