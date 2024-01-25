import 'package:flutter/cupertino.dart';
import 'package:showny/api/new_api/api_service.dart';

import '../../../../models/get_banner_minishop_model.dart';
import '../../../../models/get_bannerlist_response_model.dart';

class MiniShopBannerProvider extends ChangeNotifier {
  GetBannerListResponseModel? _getBannerListResponseModel;
  GetBannerMiniShopModel? _getBannerMiniShopModel;

  GetBannerListResponseModel? get getBannerListResponseModel =>
      _getBannerListResponseModel;

  GetBannerMiniShopModel? get getBannerMiniShopModel => _getBannerMiniShopModel;

  bool _isBannerLoading = true;
  bool _isMiniShopBannerLoading = true;

  bool getIsBannerLoading() => _isBannerLoading;
  bool getIsMiniShopBannerLoading() => _isMiniShopBannerLoading;

  setIsBannerLoading(bool value) {
    _isBannerLoading = value;
    notifyListeners();
  }

  setIsMiniShopBannerLoading(bool value) {
    _isMiniShopBannerLoading = value;
    notifyListeners();
  }

  getBannerList(String memNo, String type) {
    if (!_isBannerLoading) {
      setIsBannerLoading(true);
    }
    ApiService().getBannerListApi(memNo, type).then((getBannerListSuccess) {
      if (getBannerListSuccess!.success!) {
        _getBannerListResponseModel = getBannerListSuccess;
        setIsBannerLoading(false);
        notifyListeners();
      }
    });
  }

  getMiniShopBannerData(String memNo, String type) {
    if (!_isMiniShopBannerLoading) {
      setIsMiniShopBannerLoading(true);
    }
    ApiService()
        .getBannerMiniShopApi(memNo: memNo, type: type)
        .then((getMiniShopBannerListSuccess) {
      if (getMiniShopBannerListSuccess!.success!) {
        _getBannerMiniShopModel = getMiniShopBannerListSuccess;
        setIsMiniShopBannerLoading(false);
        notifyListeners();
      }
    });
  }
}
