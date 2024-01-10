import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/models/store_good_model.dart';

class StoreDetailFilterProvider extends ChangeNotifier {
  final List<String> categoryList = [
    tr('mini_shop.category.all'),
    tr('mini_shop.category.outer'),
    tr('mini_shop.category.tops'),
    tr('mini_shop.category.bottoms'),
    tr('mini_shop.category.shoes'),
    tr('mini_shop.category.accessories'),
    tr('mini_shop.category.stuff'),
  ];

  int _selectedTabFilter = StoreSelectionTab.men;
  int _selectedCategory = 0;
  int? _minPrice;
  int? _maxPrice;
  BrandData? _selectedBrand;
  bool _isStoreListLoading = true;
  List<StoreGoodModel> _goods = [];
  List<int> _styleIdList = [];
  List<int> _fitIdList = [];
  List<int> _materialIdList = [];
  List<int> _colorIdList = [];
  int _goodsCount = 0;
  bool _showFit = false;
  bool _showMainMaterial = false;
  bool _showRange = false;
  double _sliderRangeValue = 1;
  bool _showColor = false;

  bool get showColor => _showColor;

  bool get showFit => _showFit;

  bool get showMainMaterial => _showMainMaterial;

  bool get showRange => _showRange;

  double get sliderRangeValue => _sliderRangeValue;

  int getSelectedTabFilter() => _selectedTabFilter;

  void toggleFit() {
    _showFit = !_showFit;
    notifyListeners();
  }

  void toggleColor() {
    _showColor = !_showColor;
    notifyListeners();
  }

  void toggleMaterial() {
    _showMainMaterial = !_showMainMaterial;
    notifyListeners();
  }

  void toggleRange() {
    _showRange = !_showRange;
    notifyListeners();
  }

  void setSliderRangeValue(double value) {
    _sliderRangeValue = value;
    notifyListeners();
  }

  setSelectedTabFilter(int value) {
    _selectedTabFilter = value;
    notifyListeners();
  }

  int getSelectedCategory() => _selectedCategory;

  setSelectedCategory(int value) {
    _selectedCategory = value;
    notifyListeners();
  }

  BrandData? getSelectedBrand() => _selectedBrand;

  setSelectedBrand(BrandData? value) {
    _selectedBrand = value;
    notifyListeners();
  }

  bool getIsStoreListLoading() => _isStoreListLoading;

  setIsStoreListLoading(bool value) {
    _isStoreListLoading = value;
    notifyListeners();
  }

  List<StoreGoodModel> getGoods() => _goods;

  setGoods(List<StoreGoodModel> value) {
    _goods = value;
    notifyListeners();
  }

  int getGoodsCount() => _goodsCount;

  setGoodsCount(int value) {
    _goodsCount = value;
    notifyListeners();
  }

  getGoodListSearch({required String memNo}) {
    if (!getIsStoreListLoading()) {
      setIsStoreListLoading(true);
    }

    String cateCd = '';
    switch (getSelectedTabFilter()) {
      case StoreSelectionTab.men:
        cateCd = '008';
        break;
      case StoreSelectionTab.women:
        cateCd = '007';
        break;
    }

    String subCateCd = '';
    if(getSelectedCategory() == 1) {
      subCateCd += '001';
    }
    else if(getSelectedCategory() == 2) {
      subCateCd += '002';
    }
    else if(getSelectedCategory() == 3) {
      subCateCd += '003';
    }
    else if(getSelectedCategory() == 4) {
      subCateCd += '004';
    }
    else if(getSelectedCategory() == 5) {
      subCateCd += '005';
    }
    else if(getSelectedCategory() == 6) {
      subCateCd += '006';
    }

    // ApiHelper.shared.getGoodsList(
    //   memNo, 
    //   keyword, 
    //   mainCategory, 
    //   subCategory, 
    //   brandCd, 
    //   sort, 
    //   minPrice, 
    //   maxPrice, 
    //   styleIdList, 
    //   fitIdList, 
    //   materialIdList, 
    //   flexibility, 
    //   page, 
    //   (goodsList) {

    //   }, 
    //   (error) => {

    //   });

    // ApiService()
    //     .getGoodsSearchApi(
    //         memNo,
    //         '',
    //         cateCd,
    //         subCateCd,
    //         (getSelectedBrand() != null ? getSelectedBrand()!.cateCd : ''))
    //     .then((getGoodsListSearchSuccess) {
    //   if (getGoodsListSearchSuccess!.success!) {
    //     setGoods(getGoodsListSearchSuccess.data!.goodsData!);
    //     setGoodsCount(getGoodsListSearchSuccess.data!.totalCount ?? 0);
    //     setIsStoreListLoading(false);
    //   }
    // });
  }

  List<int> getStyleIdList() => _styleIdList;

  setStyleIdList(List<int> value) {
    _styleIdList = value;
    notifyListeners();
  }

  List<int> getFitIdList() => _fitIdList;

  setFitIdList(List<int> value) {
    _fitIdList = value;
    notifyListeners();
  }

  List<int> getMaterialIdList() => _materialIdList;

  setMaterialIdList(List<int> value) {
    _materialIdList = value;
    notifyListeners();
  }

  List<int> getColorIdList() => _colorIdList;

  setColorIdList(List<int> value) {
    _colorIdList = value;
    notifyListeners();
  }

  int? getMaxPrice() => _maxPrice;

  setMaxPrice(int? value) {
    _maxPrice = value;
    notifyListeners();
  }

  int? getMinPrice() => _minPrice;

  setMinPrice(int? value) {
    _minPrice = value;
    notifyListeners();
  }

  resetFilter() {
    _minPrice = null;
    _maxPrice = null;
    _styleIdList.clear();
    _fitIdList.clear();
    _materialIdList.clear();
    // _sliderRangeValue = 0;
    _showRange = false;
    _colorIdList.clear();
    notifyListeners();
  }
}
