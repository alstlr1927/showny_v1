import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showny/components/logger/showny_logger.dart';

import 'package:showny/models/GetMemberMinishopProductReviewModel.dart';
import 'package:showny/models/StoreOrderListModel.dart';
import 'package:showny/screens/profile/model/get_myshopping_response_model.dart';
import 'package:showny/screens/profile/model/get_profile_response_model.dart';
import 'package:showny/screens/profile/model/get_store_canclelist_response_model.dart';
import 'package:showny/screens/profile/model/get_store_cart_list_response_model.dart';
import 'package:showny/screens/profile/model/getcancle_info_detail_response_model.dart';

import '../../constants.dart';
import '../../models/FetchGetMemberMinishopProductModel.dart';
import '../../models/GetMemberMinishopProductSheetModel.dart';
import '../../models/brand_search_model.dart';
import '../../models/get_banner_minishop_model.dart';
import '../../models/get_bannerlist_response_model.dart';
import '../../models/get_storelist_response_model.dart' as mainlist;
import '../../models/minishop_search_model.dart';

//TODO api_helper로 통합 예정

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  final String baseUrl = 'http://api.applrdev193.godomall.com';
  Dio dio = Dio();

  /// new add
  Future<GetBannerListResponseModel?> getBannerListApi(
      String memNo, String type) async {
    GetBannerListResponseModel? getBannerListResponseModel;
    try {
      var request = json.encode({"memNo": memNo, "type": type});
      var response = await dio.post(
        '$baseUrl/GetBannerList',
        data: request,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.statusCode == 200) {
        log("BANNER :: ${response.data}");
        getBannerListResponseModel =
            GetBannerListResponseModel.fromJson(response.data);
        return getBannerListResponseModel;
      } else {
        log('Error: ${response.statusCode}, ${response.statusMessage}');
        return getBannerListResponseModel;
      }
    } catch (e) {
      log('Error: $e');
      return getBannerListResponseModel;
    }
  }

  Future<GetBannerMiniShopModel?> getBannerMiniShopApi({
    String? memNo,
    String? type,
  }) async {
    String url = '$baseUrl/GetBannerList';

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'memNo': '$memNo',
      'type': '$type',
    };

    try {
      var response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        log("SUCCESS BANNER MINI SHOP :: ${response.data}");
        return GetBannerMiniShopModel.fromJson(response.data);
      } else {
        log("Failed to load data from the server");
        return null;
      }
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  Future<mainlist.GetStoreListResponseModel?> getStoreMainListApi(
      String memNo) async {
    mainlist.GetStoreListResponseModel? getStoreListResponseModel;

    try {
      var request = json.encode(
        {
          "memNo": memNo,
        },
      );
      var response = await dio.post(
        '$baseUrl/GetStoreMainList',
        data: {
          "memNo": memNo,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        log("STORE LIST :: ${response.data}");
        getStoreListResponseModel =
            mainlist.GetStoreListResponseModel.fromJson(response.data);
        var home = mainlist.HomeList(
            goodsNo: "1000000011",
            brandNm: "노스페이스",
            brandCd: "19",
            goodsNm: "노스페이스_아우터_화이트라벨 노벨티 눕시 다운 자켓",
            goodsImage:
                "http://gdadmin.applrdev193.godomall.com/data/editor/goods/231120/3683428_16989888359448_500_040208.jpeg",
            goodsPrice: "99000");
        var home2 = mainlist.HomeList(
            goodsNo: "1000000012",
            brandNm: "노스페이스",
            brandCd: "19",
            goodsNm: "노스페이스_아우터_화이트라벨 노벨티 눕시 다운 자켓",
            goodsImage:
                "http://gdadmin.applrdev193.godomall.com/data/editor/goods/231120/3683623_16989901706740_500_042519.jpeg",
            goodsPrice: "99000");
        var home3 = mainlist.HomeList(
            goodsNo: "1000000013",
            brandNm: "노스페이스",
            brandCd: "19",
            goodsNm: "노스페이스_아우터_화이트라벨 컴피 알파 플리스 집업",
            goodsImage:
                "http://gdadmin.applrdev193.godomall.com/data/editor/goods/231120/3573954_16951067202850_500_042716.jpeg",
            goodsPrice: "99000");
        var home4 = mainlist.HomeList(
            goodsNo: "1000000014",
            brandNm: "노스페이스",
            brandCd: "19",
            goodsNm: "노스페이스_아우터_NV3NP55D 눕시 온볼 베스트",
            goodsImage:
                "http://gdadmin.applrdev193.godomall.com/data/editor/goods/231120/3686044_16992344026308_500_042832.jpeg",
            goodsPrice: "99000");
        var home5 = mainlist.HomeList(
            goodsNo: "1000000015",
            brandNm: "닥터마틴",
            brandCd: "20",
            goodsNm: "닥터마틴_신발_1460 8홀 나파 블랙 무광",
            goodsImage:
                "http://gdadmin.applrdev193.godomall.com/data/editor/goods/231120/626636_4_500_043015.jpeg",
            goodsPrice: "99000");
        var home6 = mainlist.HomeList(
            goodsNo: "1000000016",
            brandNm: "닥터마틴",
            brandCd: "20",
            goodsNm: "닥터마틴_신발_1461 3홀 블랙 스무스",
            goodsImage:
                "http://gdadmin.applrdev193.godomall.com/data/editor/goods/231120/3335921_16872295112218_500_043229.jpeg",
            goodsPrice: "99000");
        getStoreListResponseModel.data!.homeList!.add(home);
        getStoreListResponseModel.data!.homeList!.add(home2);
        getStoreListResponseModel.data!.homeList!.add(home3);
        getStoreListResponseModel.data!.homeList!.add(home4);
        getStoreListResponseModel.data!.homeList!.add(home5);
        getStoreListResponseModel.data!.homeList!.add(home6);
        return getStoreListResponseModel;
      } else {
        log('Error: ${response.statusCode}, ${response.statusMessage}');
        return getStoreListResponseModel;
      }
    } catch (e) {
      log('Error: $e');
      return getStoreListResponseModel;
    }
  }

  // Future<SearchResponseModel?> getSearchApi(String memNo) async {
  //   Dio dio = Dio();
  //   SearchResponseModel? searchResponseModel;
  //   try {
  //     var response = await dio.post(
  //       '$baseUrl/GetRecentBrandSearch',
  //       data: {'memNo': memNo},
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/x-www-form-urlencoded',
  //         },
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       log("SEARCH LIST :: ${response.data}");
  //       searchResponseModel = SearchResponseModel.fromJson(response.data);
  //       return searchResponseModel;
  //     } else {
  //       log('Error: ${response.statusCode}, ${response.statusMessage}');
  //       return searchResponseModel;
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //     return searchResponseModel;
  //   }
  // }

  Future<MinishopSearchModel?> getMinishopSearchApi(String memNo) async {
    MinishopSearchModel? minishopSearchModel;
    try {
      var response = await dio.post(
        '$baseUrl/GetMinishopRecentSearch',
        data: {'memNo': memNo},
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.statusCode == 200) {
        log("MINISHOP SEARCH LIST :: ${response.data}");
        minishopSearchModel = MinishopSearchModel.fromJson(response.data);
        return minishopSearchModel;
      } else {
        log('Error: ${response.statusCode}, ${response.statusMessage}');
        return minishopSearchModel;
      }
    } catch (e) {
      log('Error: $e');
      return minishopSearchModel;
    }
  }

  // Future<DeleteMinishopRecentSearchModel?> deleteMinishopRecentSearchApi(
  //     String memNo, String keyWord) async {
  //   DeleteMinishopRecentSearchModel? deleteMinishopRecentSearchModel;
  //   try {
  //     var response = await dio.post(
  //       '$baseUrl/DeleteMinishopRecentSearch',
  //       data: {'memNo': memNo, 'keyword': keyWord},
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/x-www-form-urlencoded',
  //         },
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       log("DELETE MINISHOP SEARCH LIST :: ${response.data}");
  //       deleteMinishopRecentSearchModel =
  //           DeleteMinishopRecentSearchModel.fromJson(response.data);
  //       return deleteMinishopRecentSearchModel;
  //     } else {
  //       log('Error: ${response.statusCode}, ${response.statusMessage}');
  //       return deleteMinishopRecentSearchModel;
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //     return deleteMinishopRecentSearchModel;
  //   }
  // }

  // Future<GetMinishopProductListModel?> getMiniShopProductListApi(
  //     {String? memNo,
  //     String? keyWord,
  //     int? productCategoryId,
  //     int? status,
  //     int? sort,
  //     int? minPrice,
  //     int? maxPrice,
  //     int? isNew}) async {
  //   Dio dio = Dio();
  //   GetMinishopProductListModel? getMinishopProductListModel;
  //   try {
  //     var response = await dio.post(
  //       '$baseUrl/GetMinishopProductList',
  //       data: {
  //         'memNo': memNo,
  //         'keyword': keyWord,
  //         'productCategoryId': productCategoryId ?? 0,
  //         'sort': sort ?? 0,
  //         'minPrice': minPrice ?? '',
  //         'maxPrice': maxPrice ?? '',
  //         'isNew': isNew ?? MiniShopProductsType.newGoods,
  //         'status': status ?? MiniShopTransactionStatus.unChecked,
  //         'page': 0,
  //       },
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/x-www-form-urlencoded',
  //         },
  //       ),
  //     );
  //     log("request Data ===>${response.requestOptions.data}");
  //     if (response.statusCode == 200) {
  //       log("MINISHOP PRODUCT  LIST :: ${response.data}");
  //       //SearchStoreGoodModelResponseModel searchStoreGoodModelResponseModelFromJson(String str) => SearchStoreGoodModelResponseModel.fromJson(json.decode(str));
  //       getMinishopProductListModel =
  //           GetMinishopProductListModel.fromJson(response.data);
  //       return getMinishopProductListModel;
  //     } else {
  //       log('Error: ${response.statusCode}, ${response.statusMessage}');
  //       return getMinishopProductListModel;
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //     return getMinishopProductListModel;
  //   }
  // }

  ///

  Future<BrandResponse?> getBrandListService(
      String memNo, String keyword) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var dio = Dio();

    try {
      Response response = await dio.request(
        '$baseUrl/GetBrandList',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: {'memNo': memNo, 'keyword': keyword},
      );

      if (response.statusCode == 200) {
        BrandResponse brandResponse = BrandResponse.fromJson(response.data);
        log(brandResponse.data[0].brandImgUrl);
        return brandResponse;
      } else {
        ShownyLog().e(
            'Failed to call API: ${response.statusCode}, ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // DioErrorType.RESPONSE
        ShownyLog().e('Dio error!');
        ShownyLog().e('STATUS: ${e.response?.statusCode}');
        ShownyLog().e('DATA: ${e.response?.data}');
        ShownyLog().e('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        ShownyLog().e('Error sending request!');
        ShownyLog().e('${e.message}');
      }
    } catch (e) {
      ShownyLog().e('Unknown error: $e');
    }
    return null;
  }

  Future<GetMyShoppingResponseModel?> getMyShoppingApi({
    String? memNo,
    String? orderNo,
  }) async {
    String url = '$baseUrl/GetMyShopping';

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {'memNo': '$memNo', 'orderNo': '$orderNo'};

    try {
      var response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        log("SUCCESS MY SHOPPING :: ${response.data}");
        return GetMyShoppingResponseModel.fromJson(response.data);
      } else {
        log("Failed to load data from the server");
        return null;
      }
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  Future<GetProfileResponseModel?> getProfileApi({
    String? memNo,
  }) async {
    String url = '$baseUrl/GetProfile';

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'memNo': '$memNo',
    };

    try {
      var response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        log("SUCCESS PROFILE :: ${response.data}");
        return GetProfileResponseModel.fromJson(response.data);
      } else {
        log("Failed to load data from the server");
        return null;
      }
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  Future<GetStoreCartListResponseModel?> getStoreCartListApi({
    String? memNo,
    int? page,
  }) async {
    String url = '$baseUrl/GetStoreCartList';

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'memNo': '$memNo',
      'page': '$page',
    };

    try {
      var response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        log("SUCCESS GET STORE CART LIST  :: ${response.data}");
        return GetStoreCartListResponseModel.fromJson(response.data);
      } else {
        log("Failed to load data from the server");
        return null;
      }
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  Future<GetStoreCancelListModel?> getStoreCancelListApi({
    String? memNo,
  }) async {
    String url = '$baseUrl/GetStoreCancleList';

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'memNo': '$memNo',
    };

    try {
      var response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        var newResponse = response.data.toString().replaceAll("Array", "");
        log("SUCCESS GET STORE CANCEL LIST  :: ${response.data}");
        return GetStoreCancelListModel.fromJson(jsonDecode(newResponse));
      } else {
        log("Failed to load data from the server");
        return null;
      }
    } catch (e) {
      var newResponse = e.toString().replaceAll("Array", "");
      log("SUCCESS GET STORE CANCEL LIST  :: ${e}");
      return GetStoreCancelListModel.fromJson(jsonDecode(newResponse));
      log("Error: $e");
      return null;
    }
  }

  Future<GetStoreCancelInfoDetailModel?> getCancelInfoDetailApi({
    String? memNo,
    String? orderNo,
  }) async {
    String url = '$baseUrl/GetCancleInfoDetail';

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'memNo': '$memNo',
      'orderNo': '$orderNo',
    };

    try {
      var response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        log("SUCCESS GET STORE CANCEL INFO DETAIL   :: ${response.data}");
        return GetStoreCancelInfoDetailModel.fromJson(response.data);
      } else {
        log("Failed to load data from the server");
        return null;
      }
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  Future<GetMemberMinishopProductReviewModel> fetchMemberMinishopProductReview(
      String memNo, String page) async {
    var data = FormData.fromMap({'memNo': memNo, 'page': page});

    var dio = Dio();
    var response = await dio.request(
      '$baseUrl/getMemberMinishopProductReview',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      log("${response.data}", name: "ds");
      return GetMemberMinishopProductReviewModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<GetMemberMinishopProductSheetModel>
      fetchMemberMinishopProductSheet() async {
    var dio = Dio();
    var response = await dio.request(
      '$baseUrl/GetMinishopProductReviewReportType',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      return GetMemberMinishopProductSheetModel.fromJson((response.data));
    } else {
      return GetMemberMinishopProductSheetModel();
    }
  }

  Future<FetchGetMemberMinishopProductModel> fetchGetMemberMinishopProduct(
      memNo, status, page) async {
    var data = FormData.fromMap(
        {'memNo': memNo, 'status': '$status', 'page': '$page'});

    var dio = Dio();
    var response = await dio.request(
      '$baseUrl/getMemberMinishopProduct',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return FetchGetMemberMinishopProductModel.fromJson((response.data));
    } else {
      return FetchGetMemberMinishopProductModel();
    }
  }

  Future<StoreOrderListResponse> fetchStoreOrderList({memNo}) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {'memNo': '1068', 'status': '3'};

    var dio = Dio();
    try {
      var response = await dio.request(
        '$baseUrl/GetStoreOrderList',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return StoreOrderListResponse.fromJson(response.data);
      } else {
        print(response.statusMessage);
        return StoreOrderListResponse();
      }
    } on DioException catch (e) {
      // Handle the error

      print(e.message);
      return StoreOrderListResponse();
    }
  }

  Future<bool> updateMinishopProductStatus(
      {String? memNo, String? productId, String? status}) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var data = {'memNo': memNo, 'productId': productId, 'status': status};
    var dio = Dio();

    try {
      var response = await dio.request(
        '$baseUrl/UpdateMinishopProductStatus',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.requestOptions.data);

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return true;
      } else {
        print(response.statusMessage);
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

  Future<bool> updateMiniShopProductReview(
      {required String memNo,
      required String productReviewId,
      required String reportTypeNo}) async {
    var data = FormData.fromMap({
      'memNo': memNo,
      'productReviewId': productReviewId,
      'reportTypeNo': reportTypeNo
    });
    var dio = Dio();

    try {
      var response = await dio.request(
        '$baseUrl/InsertMinishopProductReviewReportController',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      print(response.requestOptions.data);

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return true;
      } else {
        print(response.statusMessage);
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }
}
