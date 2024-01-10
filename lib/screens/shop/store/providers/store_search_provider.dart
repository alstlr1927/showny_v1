import 'package:flutter/cupertino.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/recent_search_list_model.dart';
import 'package:showny/models/store_good_model.dart';

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
  String? _barndCd;
  int? _sort;
  int? _minPrice;
  int? _maxPrice;
  List<int>? _styleIdList;
  List<int>? _fitIdList;
  List<int>? _materialIdList;
  List<int>? _flexibility;

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
     _barndCd;
    _sort;
    _minPrice;
    _maxPrice;
    _styleIdList;
    _fitIdList;
    _materialIdList;
    _flexibility;

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
    _barndCd = value;
    notifyListeners();
  }

  void setSort(int value) {
    _sort = value;
    notifyListeners();
  }

  void setMinPrice(int value) {
    _minPrice = value;
    notifyListeners();
  }

  void setMaxPrice(int value) {
    _maxPrice = value;
    notifyListeners();
  }

  void setStyleIdList(List<int> value) {
    _styleIdList = value;
    notifyListeners();
  }

  void setFitIdList(List<int> value) {
    _fitIdList = value;
    notifyListeners();
  }

  void setMaterialIdList(List<int> value) {
    _materialIdList = value;
    notifyListeners();
  }

  void setFlexibility(List<int> value) {
    _flexibility = value;
    notifyListeners();
  }

  List<StoreGoodModel> get goodsList => _goodsList;

  RecentSearchListModel get recentSearchList => _recentSearchListModel;

  bool get isRecentSearchLoading => _isRecentSearchLoading;

  bool get isSearchLoading => _isSearchLoading;

  bool get isSearched => _isSearched;

  String get searchText => _searchText;

  String get mainCategory => _mainCategory;

  String get subCategory => _subCategory;

  String? get brandCd => _barndCd;

  int? get sort => _sort;

  int? get minPrice => _minPrice;

  int? get maxPrice => _maxPrice;

  List<int>? get styleIdList => _styleIdList;

  List<int>? get fitIdList => _fitIdList;

  List<int>? get materialIdList => _materialIdList;

  List<int>? get flexibility => _flexibility;
  

  void getRecentSearchList(memNo) {
    setIsRecentSearchLoading(true);
    ApiHelper.shared.getStoreRecentSearch(
      memNo, 
      (recentSearchList){
        _recentSearchListModel = recentSearchList;
        setIsRecentSearchLoading(false);
        notifyListeners();
      }, 
      (error){
        setIsRecentSearchLoading(false);
        notifyListeners();
      });
  }

  void deleteRecentSearch(memNo, keyword) {
    ApiHelper.shared.deleteStoreRecentSearch(
      memNo, 
      keyword, 
      (success) => null, 
      (error) => null);
  }

  void getSearchList(memNo) {

    setIsSearchLoading(true);
    ApiHelper.shared.getGoodsList(
      memNo, 
      searchText, 
      mainCategory, 
      subCategory, 
      brandCd, 
      sort, 
      minPrice, 
      maxPrice, 
      styleIdList, 
      fitIdList, 
      materialIdList, 
      flexibility, 
      page, 
      (response) {
        _goodsList = response.goodsList;
        searchResultCount = response.totalCount;
        setIsSearchLoading(false);
        setIsSearched(true);
        notifyListeners();
      }, 
      (error){
        setIsSearchLoading(false);
      });
  }
}