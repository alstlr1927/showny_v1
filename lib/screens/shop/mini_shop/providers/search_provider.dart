import 'package:flutter/cupertino.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/store_good_model.dart';

import '../../../../models/delete_minishop_recentsearch_model.dart';
import '../../../../models/minishop_search_model.dart';
import '../../../../models/product.dart';
import '../../../../models/search_goods_response_model.dart';
import '../../../../models/search_model.dart';

class SearchProvider extends ChangeNotifier {
  SearchResponseModel? _searchResponseModel;
  SearchStoreGoodModelResponse? _searchStoreGoodModelResponseModel;
  MinishopSearchModel? _minishopSearchModel;
  DeleteMinishopRecentSearchModel? _deleteMinishopRecentSearchModel;
  // GetMinishopProductListModel? _getMinishopProductListModel;

  List<bool> _isTrue = [];

  List<bool> get isTrue => _isTrue;

  bool _isHeartClick = false;

  String _searchText = "";
  bool _isClearVisibleMinishopSearch = false;
  bool _isClearVisibleMinishopSearch1 = false;
  bool _isClearVisibleStoreSearch = false;
  bool _isClearVisibleStoreSearch1 = false;
  bool _totalSearchVisibleMinishop = false;
  bool _totalSearchVisibleStore = false;
  bool _isSearchClick = false;
  int _selectedCategory = 0;
  int _selectedSorting = 0;
  int _transactionStatus = MiniShopSearchTransactionStatus.unChecked;
  int? _productType = MiniShopSearchProductsType.oldOnes;
  int _viewWearingShot = MiniShopSearchProductsViewWearingShot.hide;
  int? _minPrice;
  int? _maxPrice;
  List<Product> _products = [];

  List<Product> getProducts() => _products;

  setProducts(List<Product> value) {
    _products = value;
    notifyListeners();
  }

  bool get isHeartClick => _isHeartClick;

  SearchResponseModel? get searchResponseModel => _searchResponseModel;

  MinishopSearchModel? get minishopSearchModel => _minishopSearchModel;

  DeleteMinishopRecentSearchModel? get deleteMinishopRecentSearchModel =>
      _deleteMinishopRecentSearchModel;

  SearchStoreGoodModelResponse? get searchStoreGoodModelResponseModel =>
      _searchStoreGoodModelResponseModel;

  // GetMinishopProductListModel? get getMinishopProductListModel =>
  //     _getMinishopProductListModel;

  bool _isSearchLoading = true;
  bool _isSearchLoading1 = true;
  bool _isSearchLoading2 = true;
  bool _isSearchLoading3 = true;
  bool _isSorted = false;

  String? _selectedDropdownItem = "추천순";

  int _indexTab = 0;

  int get indexTab => _indexTab;

  String? get selectedDropdownItem => _selectedDropdownItem;

  bool get isSorted => _isSorted;

  int _subCategory = 4;

  int get subCategory => _subCategory;

  set selectedDropdownItem(String? newValue) {
    _selectedDropdownItem = newValue;
    notifyListeners();
  }

  int getViewWearingShot() => _viewWearingShot;

  setViewWearingShot(int value) {
    _viewWearingShot = value;
    notifyListeners();
  }

  bool getIsSearchLoading() => _isSearchLoading;

  bool getIsSearchLoading1() => _isSearchLoading1;

  bool getIsSearchLoading2() => _isSearchLoading2;

  bool getIsSearchLoading3() => _isSearchLoading3;

  bool getIsClearVisibleMinishopSearch() => _isClearVisibleMinishopSearch;

  bool getIsClearVisibleMinishopSearch1() => _isClearVisibleMinishopSearch1;

  bool getIsClearVisibleStoreSearch() => _isClearVisibleStoreSearch;

  bool getIsClearVisibleStoreSearch1() => _isClearVisibleStoreSearch1;

  bool getTotalSearchVisibleMinishop() => _totalSearchVisibleMinishop;

  bool getTotalSearchVisibleStore() => _totalSearchVisibleStore;

  bool getIsSearchClick() => _isSearchClick;

  String get searchText => _searchText;

  int getSelectedCategory() => _selectedCategory;

  int getTransactionStatus() => _transactionStatus;

  int getSelectedSorting() => _selectedSorting;

  int? getProductType() => _productType;

  setProductType(int value) {
    _productType = value;
    notifyListeners();
  }

  setSelectedSorting(int value) {
    _selectedSorting = value;
    notifyListeners();
  }

  setTransactionStatus(int value) {
    _transactionStatus = value;
    notifyListeners();
  }

  setSelectedCategory(int value) {
    _selectedCategory = value;
    notifyListeners();
  }

  int? getMaxPrice() => _maxPrice;

  setMaxPrice(int value) {
    _maxPrice = value;
    notifyListeners();
  }

  int? getMinPrice() => _minPrice;

  setMinPrice(int value) {
    _minPrice = value;
    notifyListeners();
  }

  updateIndexSubCategory(value) {
    _subCategory = value;
    notifyListeners();
  }

  setIsSearchLoading(bool value) {
    _isSearchLoading = value;
    notifyListeners();
  }

  setIsSearchLoading1(bool value) {
    _isSearchLoading1 = value;
    notifyListeners();
  }

  setIsSearchLoading2(bool value) {
    _isSearchLoading2 = value;
    notifyListeners();
  }

  setIsSearchLoading3(bool value) {
    _isSearchLoading3 = value;
    notifyListeners();
  }

  setIsClearVisibleMinishopSearch(bool value) {
    _isClearVisibleMinishopSearch = value;
    notifyListeners();
  }

  setIsClearVisibleMinishopSearch1(bool value) {
    _isClearVisibleMinishopSearch1 = value;
    notifyListeners();
  }

  setIsClearVisibleStoreSearch(bool value) {
    _isClearVisibleStoreSearch = value;
    notifyListeners();
  }

  setIsClearVisibleStoreSearch1(bool value) {
    _isClearVisibleStoreSearch1 = value;
    notifyListeners();
  }

  setIsTotalSearchVisibleMinishop(bool value) {
    _totalSearchVisibleMinishop = value;
    notifyListeners();
  }

  setIsTotalSearchVisibleStore(bool value) {
    _totalSearchVisibleStore = value;
    notifyListeners();
  }

  setIsSearchClick(bool value) {
    _isSearchClick = value;
    notifyListeners();
  }

  setIsSearch(String value) {
    _searchText = value;
    notifyListeners();
  }

  updateIndex(value) {
    _indexTab = value;
    notifyListeners();
  }

  getSearch(String memNo) {
    if (!_isSearchLoading) {
      setIsSearchLoading(true);
    }
    ApiService().getSearchApi(memNo).then((getSearchSuccess) {
      if (getSearchSuccess!.success) {
        _searchResponseModel = getSearchSuccess;
        setIsSearchLoading(false);
        notifyListeners();
      }
    });
  }

  getMinishopSearch(String memNo) {
    if (!_isSearchLoading2) {
      setIsSearchLoading2(true);
    }
    ApiService().getMinishopSearchApi(memNo).then((getMinishopSearchSuccess) {
      if (getMinishopSearchSuccess!.success!) {
        _minishopSearchModel = getMinishopSearchSuccess;
        setIsSearchLoading2(false);
        notifyListeners();
      }
    });
  }

  deleteMinishopSearch(String memNo, String keyWord) {
    ApiService()
        .deleteMinishopRecentSearchApi(memNo, keyWord)
        .then((deleteMinishopSearchSuccess) {
      if (deleteMinishopSearchSuccess!.success!) {
        _deleteMinishopRecentSearchModel = deleteMinishopSearchSuccess;
        getMinishopSearch(memNo);
        notifyListeners();
      }
    });
  }

  getGoodListSearch(
      String memNo, String keyWord, String cat, String subCat, String brandCd) {
    if (!_isSearchLoading1) {
      setIsSearchLoading1(true);
    }

    // ApiService()
    //     .getGoodsSearchApi(
    //         memNo,
    //          keyWord,
    //          cat,
    //          subCat,
    //          brandCd)
    //     .then((getGoodsListSearchSuccess) {
    //   if (getGoodsListSearchSuccess!.success!) {
    //     resetSorting();
    //     //for (var element in getGoodsListSearchSuccess!.data!.goodsData!) { _isTrue.add(element. ?? false);}
    //     _searchStoreGoodModelResponseModel = getGoodsListSearchSuccess;
    //     setIsSearchLoading1(false);
    //     notifyListeners();
    //   }
    // });
  }

  // getMinishopProductList(
  //     {String? memNo, String? keyWord, int? productCategoryId,int?status,int?sort,int?minPrice,int?maxPrice,int?isNew}) {
  //   if (!_isSearchLoading3) {
  //     setIsSearchLoading3(true);
  //   }
  //   ApiService()
  //       .getMiniShopProductListApi(
  //           memNo: memNo,
  //           keyWord: keyWord,
  //           productCategoryId: productCategoryId,status: status,sort: sort,isNew: isNew,maxPrice: maxPrice,minPrice: minPrice)
  //       .then((getMinishopProductListSuccess) {
  //     if (getMinishopProductListSuccess!.success!) {
  //       resetSorting();
  //       //for (var element in getGoodsListSearchSuccess!.data!.goodsData!) { _isTrue.add(element. ?? false);}
  //       _getMinishopProductListModel = getMinishopProductListSuccess;
  //       setIsSearchLoading3(false);
  //       notifyListeners();
  //     }
  //   });
  // }

  getMinishopProductList({String? memNo, String? keyWord}) {
    if (!getIsSearchLoading3()) {
      setIsSearchLoading3(true);
    }
    ApiService()
        .getMiniShopProductListApi(
            memNo: memNo,
            keyWord: keyWord,
            productCategoryId: getSelectedCategory(),
            status: getTransactionStatus(),
            sort: getSelectedSorting(),
            isNew: getProductType(),
            maxPrice: getMaxPrice(),
            minPrice: getMinPrice())
        .then((value) {
      if (value!.success!) {
        setProducts(value.data ?? []);
        setIsSearchLoading3(false);
      }
    });
  }

  List<StoreGoodModel>? _sortedStoreGoodModel;

  List<StoreGoodModel>? get sortedStoreGoodModel => _sortedStoreGoodModel;

  void sortStoreGoodModelLowestPrice() {
    // sortedStoreGoodModel!.clear();

    setIsSearchLoading(true);
    if (_searchStoreGoodModelResponseModel != null &&
        _searchStoreGoodModelResponseModel!.data != null &&
        _searchStoreGoodModelResponseModel!.data!.goodsData != null) {
      _sortedStoreGoodModel =
          List.from(_searchStoreGoodModelResponseModel!.data!.goodsData!);
      _sortedStoreGoodModel!
          .sort((a, b) => (a.goodsPrice).compareTo(b.goodsPrice));
      _isSorted = true;
      setIsSearchLoading(false);
      notifyListeners();
    } else {
      setIsSearchLoading(false);
      notifyListeners();
    }
  }

  void sortStoreGoodModelHighestPrice() {
    // sortedStoreGoodModel!.clear();
    setIsSearchLoading(true);
    if (_searchStoreGoodModelResponseModel != null &&
        _searchStoreGoodModelResponseModel!.data != null &&
        _searchStoreGoodModelResponseModel!.data!.goodsData != null) {
      _sortedStoreGoodModel =
          List.from(_searchStoreGoodModelResponseModel!.data!.goodsData!);
      _sortedStoreGoodModel!
          .sort((a, b) => (b.goodsPrice).compareTo(a.goodsPrice));
      _isSorted = true;
      setIsSearchLoading(false);
      notifyListeners();
    } else {
      setIsSearchLoading(false);
      notifyListeners();
    }
  }

  void sortStoreGoodModelHighestHeart() {
    // sortedStoreGoodModel!.clear();
    setIsSearchLoading(true);
    if (_searchStoreGoodModelResponseModel != null &&
        _searchStoreGoodModelResponseModel!.data != null &&
        _searchStoreGoodModelResponseModel!.data!.goodsData != null) {
      _sortedStoreGoodModel =
          List.from(_searchStoreGoodModelResponseModel!.data!.goodsData!);
      _sortedStoreGoodModel!
          .sort((a, b) => (b.heartCount).compareTo(a.heartCount));
      _isSorted = true;
      setIsSearchLoading(false);
      notifyListeners();
    } else {
      setIsSearchLoading(false);
      notifyListeners();
    }
  }

  void sortStoreGoodModelHighestReview() {
    // sortedStoreGoodModel!.clear();
    setIsSearchLoading(true);
    if (_searchStoreGoodModelResponseModel != null &&
        _searchStoreGoodModelResponseModel!.data != null &&
        _searchStoreGoodModelResponseModel!.data!.goodsData != null) {
      _sortedStoreGoodModel =
          List.from(_searchStoreGoodModelResponseModel!.data!.goodsData!);
      _sortedStoreGoodModel!
          .sort((a, b) => (b.reviewCount).compareTo(a.reviewCount));
      _isSorted = true;
      setIsSearchLoading(false);
      notifyListeners();
    } else {
      setIsSearchLoading(false);
      notifyListeners();
    }
  }

  void resetSorting() {
    _isSorted = false;
    notifyListeners();
  }

  setIsHeartClick() {
    _isHeartClick = !_isHeartClick;
    notifyListeners();
  }

  updateHeartStatus(bool status, int index) {
    _isTrue[index] = status;
    notifyListeners();
  }
}
