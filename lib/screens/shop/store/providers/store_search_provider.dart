import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:showny/models/filter_shop_model.dart';
import 'package:showny/models/recent_search_list_model.dart';
import 'package:showny/models/store_good_model.dart';

import '../../../../api/new_api/api_helper.dart';

class StoreSearchMainCategory {
  static const String all = "";
  static const String men = "008";
  static const String women = "007";
}

class StoreSearchProvider extends ChangeNotifier {
  RecentSearchListModel _recentSearchListModel = RecentSearchListModel();
  List<StoreGoodModel> _goodsList = [];
  int searchResultCount = 0;

  bool _isRecentSearchLoading = false;
  bool _isSearchLoading = false;
  bool _isSearched = false;

  String _searchText = "";
  String _mainCategory = "";
  String _subCategory = "";
  String? _brandCd;

  int page = 0;

  void initParams() {
    _recentSearchListModel = RecentSearchListModel();
    _goodsList = [];
    searchResultCount = 0;

    _isRecentSearchLoading = false;
    _isSearchLoading = false;
    _isSearched = false;

    _searchText = "";
    _mainCategory = "";
    _subCategory = "";
    _brandCd;
    // _sort;
    // _minPrice;
    // _maxPrice;
    // _styleIdList;
    // _fitIdList;
    // _materialIdList;
    // _flexibility;

    page = 0;
    notifyListeners();
  }

  void setSearchText(value) {
    _searchText = value;
    notifyListeners();
  }

  void setIsRecentSearchLoading(value) {
    _isRecentSearchLoading = value;
    notifyListeners();
  }

  void setIsSearchLoading(value) {
    _isSearchLoading = value;
    notifyListeners();
  }

  void setIsSearched(value) {
    _isSearched = value;
    notifyListeners();
  }

  void setMainCategory(int value) {
    String mainCategory = "";
    switch (value) {
      case 0:
        mainCategory = "007";
      case 1:
        mainCategory = "008";
      default:
        mainCategory = "";
    }
    _mainCategory = mainCategory;
    notifyListeners();
  }

  void setSubCategory(int value) {
    String subCategory = "";
    switch (value) {
      case 0:
        subCategory = "";
      case 1:
        subCategory = "001";
      case 2:
        subCategory = "002";
      case 3:
        subCategory = "003";
      case 4:
        subCategory = "004";
      case 5:
        subCategory = "005";
      case 6:
        subCategory = "006";
      default:
        subCategory = "";
    }

    _subCategory = subCategory;
    notifyListeners();
  }

  void setBrandCd(String value) {
    _brandCd = value;
    notifyListeners();
  }

  // void setSort(int value) {
  //   _sort = value;
  //   notifyListeners();
  // }

  // void setMinPrice(int? value) {
  //   _minPrice = value;
  //   notifyListeners();
  // }

  // void setMaxPrice(int? value) {
  //   _maxPrice = value;
  //   notifyListeners();
  // }

  // void setStyleIdList(List<int> value) {
  //   _styleIdList = value;
  //   notifyListeners();
  // }

  // void setFitIdList(List<int> value) {
  //   _fitIdList = value;
  //   notifyListeners();
  // }

  // void setMaterialIdList(List<int> value) {
  //   _materialIdList = value;
  //   notifyListeners();
  // }

  // void setFlexibility(int value) {
  //   _flexibility = value;
  //   notifyListeners();
  // }

  // void setColorList(List<int> value) {
  //   _colorList = value;
  //   notifyListeners();
  // }

  List<StoreGoodModel> get goodsList => _goodsList;

  RecentSearchListModel get recentSearchList => _recentSearchListModel;

  bool get isRecentSearchLoading => _isRecentSearchLoading;

  bool get isSearchLoading => _isSearchLoading;

  bool get isSearched => _isSearched;

  String get searchText => _searchText;

  String get mainCategory => _mainCategory;

  String get subCategory => _subCategory;

  String? get brandCd => _brandCd;

  // int get sort => _sort;

  // int? get minPrice => _minPrice;

  // int? get maxPrice => _maxPrice;

  // List<int> get styleIdList => _styleIdList;

  // List<int> get fitIdList => _fitIdList;

  // List<int> get materialIdList => _materialIdList;

  // int get flexibility => _flexibility;

  // List<int> get colorList => _colorList;

  void getRecentSearchList(memNo) {
    setIsRecentSearchLoading(true);
    ApiHelper.shared.getStoreRecentSearch(memNo, (recentSearchList) {
      _recentSearchListModel = recentSearchList;
      setIsRecentSearchLoading(false);
      notifyListeners();
    }, (error) {
      setIsRecentSearchLoading(false);
      notifyListeners();
    });
  }

  void deleteRecentSearch(memNo, keyword) {
    ApiHelper.shared.deleteStoreRecentSearch(
        memNo, keyword, (success) => null, (error) => null);
  }

  void initPage() {
    page = 0;
    goodsList.clear();
    notifyListeners();
  }

  void getSearchList(
      String memNo, FilterShopModel? filterShopModel, int isRequest) {
    setIsSearchLoading(true);
    if (page > 1 && isSearchLoading == true) {
      return;
    }
    var isRequestParam = isRequest;
    if (brandCd != null && brandCd!.isNotEmpty == true) {
      isRequestParam = 1;
    }
    ApiHelper.shared.getGoodsList(
        memNo,
        searchText,
        mainCategory,
        subCategory,
        brandCd,
        filterShopModel?.sort,
        filterShopModel?.minPrice,
        filterShopModel?.maxPrice,
        filterShopModel?.styleIdList.isNotEmpty == true
            ? jsonEncode(filterShopModel?.styleIdList)
            : null,
        filterShopModel?.fitIdList.isNotEmpty == true
            ? jsonEncode(filterShopModel?.fitIdList)
            : null,
        filterShopModel?.materialIdList.isNotEmpty == true
            ? jsonEncode(filterShopModel?.materialIdList)
            : null,
        filterShopModel?.flexibility == 1
            ? null
            : filterShopModel?.flexibility != null
                ? filterShopModel!.flexibility - 1
                : null,
        filterShopModel?.colorList.isNotEmpty == true
            ? jsonEncode(filterShopModel?.colorList)
            : null,
        page,
        isRequestParam, (response) {
      if (page == 0) {
        _goodsList = response.goodsList;
      } else {
        _goodsList.addAll(response.goodsList);
      }

      searchResultCount = response.totalCount;
      setIsSearchLoading(false);
      setIsSearched(true);
      notifyListeners();
      if (response.goodsList.isNotEmpty) {
        page += 1;
      }
    }, (error) {
      setIsSearchLoading(false);
    });
  }
}
