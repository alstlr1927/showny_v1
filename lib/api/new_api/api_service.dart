import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:showny/models/GetMemberMinishopProductReviewModel.dart';
import 'package:showny/models/StoreOrderListModel.dart';
import 'package:showny/screens/profile/model/get_myshopping_response_model.dart';
import 'package:showny/screens/profile/model/get_profile_response_model.dart';
import 'package:showny/screens/profile/model/get_store_canclelist_response_model.dart';
import 'package:showny/screens/profile/model/get_store_cart_list_response_model.dart';
import 'package:showny/screens/profile/model/getcancle_info_detail_response_model.dart';

import '../../models/FetchGetMemberMinishopProductModel.dart';
import '../../models/GetMemberMinishopProductSheetModel.dart';
import '../../models/brandDearchModel.dart';

//TODO api_helper로 통합 예정

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  final String baseUrl = 'http://13.209.9.175:10020';
  Dio dio = Dio();

  Future<BrandResponse?> getBrandListService(String memNo) async {
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
        data: {'memNo': memNo},
      );

      if (response.statusCode == 200) {
        BrandResponse brandResponse = BrandResponse.fromJson(response.data);
        log(brandResponse.data[0].brandImgUrl);
        return brandResponse;
      } else {
        print(
            'Failed to call API: ${response.statusCode}, ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // DioErrorType.RESPONSE
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    } catch (e) {
      print('Unknown error: $e');
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
