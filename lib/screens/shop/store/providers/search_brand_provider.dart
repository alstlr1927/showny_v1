import 'package:flutter/cupertino.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/models/brand_search_model.dart';

class SearchBrandProvider extends ChangeNotifier {
  BrandResponse? _brandResponse;

  BrandResponse? get brandResponse => _brandResponse;

  bool _isBrandSearchLoading = true;

  bool getIsBrandSearchLoading() => _isBrandSearchLoading;

  setIsBrandSearchLoading(bool value) {
    _isBrandSearchLoading = value;
    notifyListeners();
  }

  getBrandSearch(String memNo, String keyword) {
    if (!_isBrandSearchLoading) {
      setIsBrandSearchLoading(true);
    }
    ApiService()
        .getBrandListService(memNo, keyword)
        .then((getBrandSearchSuccess) {
      if (getBrandSearchSuccess!.success) {
        _brandResponse = getBrandSearchSuccess as BrandResponse?;
        setIsBrandSearchLoading(false);
      }
    });
  }
}
