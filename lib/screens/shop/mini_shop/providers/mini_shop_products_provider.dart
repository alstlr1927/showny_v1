import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:showny/models/filter_minishop_model.dart';
import 'package:showny/models/minishop_product_model.dart';

import '../../../../api/new_api/api_helper.dart';

class MiniShopProductsProvider extends ChangeNotifier {
  final List<String> categoryList = [
    tr('mini_shop.category.all'),
    tr('mini_shop.category.outer'),
    tr('mini_shop.category.tops'),
    tr('mini_shop.category.bottoms'),
    tr('mini_shop.category.shoes'),
    tr('mini_shop.category.accessories'),
    tr('mini_shop.category.stuff'),
  ];

  final List<String> sortOptions = [
    tr('mini_shop.sort.latest'),
    tr('mini_shop.sort.recommended'),
    tr('mini_shop.sort.lowPrice'),
    tr('mini_shop.sort.highPrice'),
  ];

  List<MinishopProductModel> _recentViewProductList = [];
  List<MinishopProductModel> _products = [];
  bool _isProductsLoading = true;
  // int _viewWearingShot = MiniShopProductsViewWearingShot.hide;

  int page = 0;
  // int _selectedCategory = 0;
  // int _selectedSorting = 0;
  // int? _transactionStatus = MiniShopTransactionStatus.unChecked;
  // int? _productType = MiniShopProductsType.oldOnes;
  // int? _minPrice;
  // int? _maxPrice;

  void initPage() {
    page = 0;
  }

  resetValues() {
    _isProductsLoading = false;
    // _viewWearingShot = MiniShopProductsViewWearingShot.hide;
    // _selectedCategory = 0;
    // _selectedSorting = 0;
    // _transactionStatus = MiniShopTransactionStatus.unChecked;
    // _productType = MiniShopProductsType.newGoods;
    // _minPrice = null;
    // _maxPrice = null;
    notifyListeners();
  }

  // resetFilter() {
  //   _isProductsLoading = false;
  //   // _selectedCategory = 0;
  //   // _transactionStatus = null;
  //   // _productType = null;
  //   // _minPrice = null;
  //   // _maxPrice = null;
  //   notifyListeners();
  // }

  bool getIsProductsLoading() => _isProductsLoading;

  setIsProductsLoading(bool value) {
    _isProductsLoading = value;
    notifyListeners();
  }

  // int getSelectedCategory() => _selectedCategory;

  // setSelectedCategory(int value) {
  //   _selectedCategory = value;
  //   notifyListeners();
  // }

  // int getSelectedSorting() => _selectedSorting;

  // setSelectedSorting(int value) {
  //   _selectedSorting = value;
  //   notifyListeners();
  // }

  // int? getTransactionStatus() => _transactionStatus;

  // setTransactionStatus(int value) {
  //   _transactionStatus = value;
  //   notifyListeners();
  // }

  // int getViewWearingShot() => _viewWearingShot;

  // setViewWearingShot(int value) {
  //   _viewWearingShot = value;
  //   notifyListeners();
  // }

  List<MinishopProductModel> getProducts() => _products;

  setProducts(List<MinishopProductModel> value) {
    _products = value;
    notifyListeners();
  }

  List<MinishopProductModel> getRecentViewProductList() =>
      _recentViewProductList;

  setRecentViewProductList(List<MinishopProductModel> value) {
    _recentViewProductList = value;
    notifyListeners();
  }

  // int? getProductType() => _productType;

  // setProductType(int value) {
  //   _productType = value;
  //   notifyListeners();
  // }

  // int? getMaxPrice() => _maxPrice;

  // setMaxPrice(int value) {
  //   _maxPrice = value;
  //   notifyListeners();
  // }

  // int? getMinPrice() => _minPrice;

  // setMinPrice(int value) {
  //   _minPrice = value;
  //   notifyListeners();
  // }

  getMiniShopProductList(
    String memNo,
    String? keyWord,
    FilterMinishopModel? filterMinishopModel,
  ) {
    if (page > 0 && _isProductsLoading == true) {
      return;
    }
    if (!getIsProductsLoading()) {
      setIsProductsLoading(true);
    }

    ApiHelper.shared.getMinishopProductList(
        memNo,
        keyWord,
        filterMinishopModel?.categoryId ?? 0,
        filterMinishopModel?.sort ?? 0,
        filterMinishopModel?.minPrice,
        filterMinishopModel?.maxPrice,
        filterMinishopModel?.isNew ?? 2,
        filterMinishopModel?.isTransaction == true ? 0 : 2,
        page, (minishopProductList) {
      setProducts(minishopProductList);
      setIsProductsLoading(false);
      page += 1;
    }, (error) {
      setIsProductsLoading(false);
    });
  }

  getRecentViewMinishopProductList(String memNo) {
    ApiHelper.shared.getRecentViewMinishopProduct(memNo, (minishopProductList) {
      setRecentViewProductList(minishopProductList);
    }, (error) {});
  }
}
