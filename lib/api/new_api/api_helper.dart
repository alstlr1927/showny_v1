import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:showny/api/entities/response.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/models/GetGoodsStyleupListModel.dart';
import 'package:showny/models/GetNetworkingListModel.dart';
import 'package:showny/models/banner_model.dart';
import 'package:showny/models/battle_model.dart';
import 'package:showny/models/battle_vote_response_model.dart';
import 'package:showny/models/category_model.dart';
import 'package:showny/models/goods_item_model.dart';
import 'package:showny/models/goods_search_response_model.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/models/minishop_product_review_model.dart';
import 'package:showny/models/ranking_response_model.dart';
import 'package:showny/models/recent_search_list_model.dart';
import 'package:showny/models/report_type_model.dart';
import 'package:showny/models/search_styleup_response_model.dart';
import 'package:showny/models/search_user_response_model.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/models/styleup_battle_model.dart';
import 'package:showny/models/styleup_comment_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/models/user_model.dart';

import '../../models/goods_qna_list_response_model.dart';
import '../../models/goods_review_list_response_model.dart';

class ApiHelper {
  final String baseUrl = 'http://13.209.9.175:10020';
  // final String baseUrl = 'http://192.168.0.8:10020';

  // 싱글톤 인스턴스
  static final ApiHelper _instance = ApiHelper._internal();
  static const storage = FlutterSecureStorage();

  // private 생성자
  ApiHelper._internal();

  // 외부에서 싱글톤 인스턴스에 접근할 수 있는 getter
  static ApiHelper get shared => _instance;

  Future apiRequest(String url, FormData formData, Function(dynamic) success,
      Function(String) failure) async {
    var dio = Dio();

    var token = await storage.read(key: 'token');
    if (token != null && token != "") {
      debugPrint("token");
      debugPrint(token);
      final baseOptions =
          BaseOptions(headers: {'authorization': "Bearer $token"});
      dio = Dio(baseOptions);
    }

    Response response = await dio.post(url, data: formData);
    debugPrint(url);
    debugPrint(formData.fields.toString());
    final result = SNResponse.fromJson(response.data as Map<String, dynamic>);
    if (result.success == true) {
      // debugPrint(result.data.toString());
      return success(result.data);
    } else {
      debugPrint("error");
      return failure(result.error ?? "Error");
    }
  }

  Future signinEmail(email, password, Function(UserModel) success,
      Function(String) failure) async {
    const url = '/SigninEmail';
    FormData formData =
        FormData.fromMap({'email': email, 'password': password});

    apiRequest('$baseUrl$url', formData, (data) {
      var jsonData = (data as Map<String, dynamic>);
      String token = jsonData['authToken'] as String? ?? "";
      storage.write(key: "token", value: token);

      final result = UserModel.fromJson(jsonData);
      success(result);
    }, failure);
  }

  Future signinSns(snsId, loginType, Function(UserModel) success,
      Function(String) failure) async {
    const url = '/SigninSns';
    FormData formData =
        FormData.fromMap({'snsId': snsId, 'loginType': loginType});

    apiRequest('$baseUrl$url', formData, (data) {
      var jsonData = (data as Map<String, dynamic>);
      String token = jsonData['authToken'] as String? ?? "";
      storage.write(key: "token", value: token);

      final result = UserModel.fromJson(jsonData);
      success(result);
    }, failure);
  }

  Future signup(
      loginType,
      email,
      snsId,
      password,
      name,
      phoenNumber,
      marketingAgree,
      Function(dynamic) success,
      Function(String) failure) async {
    const url = '/Signup';
    FormData formData = FormData.fromMap({
      'loginType': loginType,
      'email': email,
      'snsId': snsId,
      'password': password,
      'name': name,
      'phoneNumber': phoenNumber,
      'marketingAgree': marketingAgree
    });

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getStyleupList(memNo, page, Function(List<StyleupModel>) success,
      Function(String) failure) async {
    const url = '/GetStyleupList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'page': page,
      'connectTime': DateFormat('yyyyMMddHHmmss').format(DateTime.now())
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StyleupModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getStyleupBattleList(memNo, keyword, page, type,
      Function(List<BattleModel>) success, Function(String) failure) async {
    const url = '/GetStyleupBattleList';
    FormData formData = FormData.fromMap(
        {'memNo': memNo, 'keyword': keyword, 'page': page, 'type': type});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => BattleModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getStyleupBattleItemList(memNo, Function(StyleupBattleModel) success,
      Function(String) failure) async {
    const url = '/GetStyleupBattleItemList';
    FormData formData = FormData.fromMap({'memNo': memNo});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = StyleupBattleModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getStyleupBattleItemListById(memNo, styleupBattleNo,
      Function(StyleupBattleModel) success, Function(String) failure) async {
    const url = '/GetStyleupBattleItemList';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'styleupBattleNo': styleupBattleNo});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = StyleupBattleModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getProfile(myMemNo, memNo, Function(UserModel) success,
      Function(String) failure) async {
    const url = '/GetProfile';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'myMemNo': myMemNo,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = UserModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getFollowerList(memNo, profileMemNo, page,
      Function(List<UserModel>) success, Function(String) failure) async {
    const url = '/GetFollowerList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'profileMemNo': profileMemNo,
      'page': page,
      'connectTime': DateFormat('yyyyMMddHHmmss').format(DateTime.now())
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getFollowList(memNo, profileMemNo, page,
      Function(List<UserModel>) success, Function(String) failure) async {
    const url = '/GetFollowList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'profileMemNo': profileMemNo,
      'page': page,
      'connectTime': DateFormat('yyyyMMddHHmmss').format(DateTime.now())
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future insertStyleupImage(
      List<XFile> filePathList,
      memNo,
      desc,
      styles,
      colorIds,
      seasonID,
      List<List<StoreGoodModel?>?>? goodsDataList,
      Function(dynamic) success,
      Function(String) failure) async {
    const url = '/InsertStyleup';

    List<GoodsItemModel> goodsItemModelList = [];

    if (goodsDataList != null) {
      for (int index = 0; index < goodsDataList.length; index++) {
        if (goodsDataList[index] != null) {
          for (int index2 = 0;
              index2 < goodsDataList[index]!.length;
              index2++) {
            GoodsItemModel goodsItemModel = GoodsItemModel();
            if (goodsDataList[index]![index2] != null) {
              var goodsItem = goodsDataList[index]![index2]!;
              goodsItemModel.contentIndex = index;
              goodsItemModel.categoryId = index2;
              goodsItemModel.goodsNo = goodsItem.goodsNo ?? "";
              goodsItemModel.goodsNm = goodsItem.goodsNm ?? "";
              goodsItemModel.goodsImg = goodsItem.goodsImageUrlList?[0] ?? "";
              goodsItemModel.goodsPrice = goodsItem.goodsPrice ?? 0;
              goodsItemModel.brandNm = goodsItem.brandNm ?? "";
              goodsItemModel.left = goodsItem.left;
              goodsItemModel.top = goodsItem.top;

              goodsItemModelList.add(goodsItemModel);
            }
          }
        }
      }
    }

    String goodsListJsonString = jsonEncode(goodsItemModelList
        .map((goodsItemModel) => goodsItemModel.toJson())
        .toList());
    String stylesJsonString = jsonEncode(styles);
    String colorsJsonString = jsonEncode(colorIds);

    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'type': 'img',
      'imgFiles': '',
      'videoFile': '',
      'thumbnailFile': '',
      'description': desc,
      'styles': stylesJsonString,
      'colors': colorsJsonString,
      'season': seasonID,
      'goodsList': goodsListJsonString,
    });

    int index = 0;
    for (var filePath in filePathList) {
      formData.files.add(
        MapEntry("imgFile$index", await MultipartFile.fromFile(filePath.path)),
      );
      index += 1;
    }

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future insertStyleupVideo(
      videoFilePath,
      thumbFilePath,
      memNo,
      desc,
      styles,
      colorIds,
      seasonID,
      List<List<StoreGoodModel?>?>? goodsDataList,
      Function(dynamic) success,
      Function(String) failure) async {
    const url = '/InsertStyleup';

    List<GoodsItemModel> goodsItemModelList = [];

    if (goodsDataList != null) {
      for (int index = 0; index < goodsDataList.length; index++) {
        if (goodsDataList[index] != null) {
          for (int index2 = 0;
              index2 < goodsDataList[index]!.length;
              index2++) {
            GoodsItemModel goodsItemModel = GoodsItemModel();
            if (goodsDataList[index]![index2] != null) {
              var goodsItem = goodsDataList[index]![index2]!;
              goodsItemModel.contentIndex = index;
              goodsItemModel.categoryId = index2;
              goodsItemModel.goodsNo = goodsItem.goodsNo ?? "";
              goodsItemModel.goodsNm = goodsItem.goodsNm ?? "";
              goodsItemModel.goodsImg = goodsItem.goodsImageUrlList?[0] ?? "";
              goodsItemModel.goodsPrice = goodsItem.goodsPrice ?? 0;
              goodsItemModel.brandNm = goodsItem.brandNm ?? "";
              goodsItemModel.left = goodsItem.left;
              goodsItemModel.top = goodsItem.top;

              goodsItemModelList.add(goodsItemModel);
            }
          }
        }
      }
    }

    String jsonString = jsonEncode(goodsItemModelList
        .map((goodsItemModel) => goodsItemModel.toJson())
        .toList());

    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'type': 'video',
      'imgFiles': '',
      'videoFile': '',
      'thumbnailFile': '',
      'description': desc,
      'styles': '["2"]',
      'colors': '["1","5","7"]',
      'season': '3',
      'goodsList': jsonString,
    });

    debugPrint(jsonString);
    debugPrint(videoFilePath);
    debugPrint(thumbFilePath);

    formData.files.add(
      MapEntry(
        'thumbnailFile',
        await MultipartFile.fromFile(thumbFilePath),
      ),
    );

    formData.files.add(
      MapEntry(
        'videoFile',
        await MultipartFile.fromFile(videoFilePath),
      ),
    );

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future insertStyleupBattleParticipation(filePath, styleupBattleNo, styleupNo,
      memNo, Function(dynamic) success, Function(String) failure) async {
    const url = '/InsertStyleupBattleParticipation';
    FormData formData = FormData.fromMap({
      'styleupBattleNo': styleupBattleNo,
      'styleupNo': styleupNo,
      'memNo': memNo,
    });

    formData.files.add(
      MapEntry(
        'thumbnailFile',
        await MultipartFile.fromFile(filePath),
      ),
    );

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future profileEdit(memNo, editFormData, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/ProfileEdit';
    FormData formData = FormData.fromMap(editFormData);

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future profileEditImage(filePath, memNo, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/ProfileEdit';
    FormData formData = FormData.fromMap({'memNo': memNo});

    formData.files.add(
      MapEntry(
        'profileImage',
        await MultipartFile.fromFile(filePath),
      ),
    );

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getMyStyleupList(memNo, page, Function(List<StyleupModel>) success,
      Function(String) failure) async {
    const url = '/GetMyStyleupList';
    FormData formData = FormData.fromMap({'memNo': memNo, 'page': page});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StyleupModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getAvailableBattleUploadStyleupList(memNo, page,
      Function(List<StyleupModel>) success, Function(String) failure) async {
    const url = '/GetMyStyleupList';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'page': page, 'type': 'img'});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StyleupModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getProfileStyleupList(memNo, type, page,
      Function(List<StyleupModel>) success, Function(String) failure) async {
    const url = '/GetProfileStyleupList';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'type': type, 'page': page});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StyleupModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future checkDuplicatedId(
      memId, Function(dynamic) success, Function(String) failure) async {
    const url = '/CheckDuplicateId';
    FormData formData = FormData.fromMap({'memId': memId});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future checkDuplicateEmail(
      email, Function(dynamic) success, Function(String) failure) async {
    const url = '/CheckDuplicateEmail';
    FormData formData = FormData.fromMap({'email': email});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future verifyPhoneNumber(email, phoneNumber, verifyCode,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/VerifyPhoneNumber';
    FormData formData = FormData.fromMap(
        {'email': email, 'phoneNumber': phoneNumber, 'verifyCode': verifyCode});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future verifyPhoneNumberSend(
      phoneNumber, Function(dynamic) success, Function(String) failure) async {
    const url = '/VerifyPhoneNumberSend';
    FormData formData = FormData.fromMap({'phoneNumber': phoneNumber});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getStyleupReportType(
      Function(List<ReportTypeModel>) success, Function(String) failure) async {
    const url = '/GetStyleupReportType';
    FormData formData = FormData.fromMap({});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => ReportTypeModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future insertStyleupReport(styleupNo, memNo, reportTypeNo,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/InsertStyleupReport';
    FormData formData = FormData.fromMap(
        {'styleupNo': styleupNo, 'memNo': memNo, 'reportTypeNo': reportTypeNo});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future selectStyleupBattleItem(
      battleRoundNo,
      selectedStyleupNo,
      otherStyleupNo,
      memNo,
      Function(BattleVoteResponseModel) success,
      Function(String) failure) async {
    const url = '/SelectStyleupBattleItem';
    FormData formData = FormData.fromMap({
      "battleRoundNo": battleRoundNo,
      "selectedStyleupNo": selectedStyleupNo,
      "otherStyleupNo": otherStyleupNo,
      "memNo": memNo
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          BattleVoteResponseModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getRecentSearch(memNo, Function(RecentSearchListModel) success,
      Function(String) failure) async {
    const url = '/GetRecentSearch';
    FormData formData = FormData.fromMap({"memNo": memNo});

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          RecentSearchListModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future searchUser(
      memNo,
      keyword,
      page,
      Function(SearchUserReseponseModel) success,
      Function(String) failure) async {
    const url = '/SearchUser';
    FormData formData = FormData.fromMap({
      "memNo": memNo,
      "keyword": keyword,
      "page": page,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          SearchUserReseponseModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future searchPost(
      memNo,
      keyword,
      page,
      Function(SearchStyleupResponseModel) success,
      Function(String) failure) async {
    const url = '/SearchPost';
    FormData formData = FormData.fromMap({
      "memNo": memNo,
      "keyword": keyword,
      "page": page,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          SearchStyleupResponseModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getRankingStyleup(memNo, Function(RankingResponseModel) success,
      Function(String) failure) async {
    const url = '/GetRankingStyleup';
    FormData formData = FormData.fromMap({"memNo": memNo});

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          RankingResponseModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getStyleupCommentList(
      styleupNo,
      memNo,
      page,
      Function(List<StyleupCommentModel>) success,
      Function(String) failure) async {
    const url = '/GetStyleupCommentList';
    FormData formData = FormData.fromMap(
        {'styleupNo': styleupNo, 'memNo': memNo, 'page': page});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) =>
              StyleupCommentModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getStyleupChildCommentList(
      styleupNo,
      memNo,
      parentStyleupCommentNo,
      page,
      Function(List<StyleupCommentModel>) success,
      Function(String) failure) async {
    const url = '/GetStyleupChildCommentList';
    FormData formData = FormData.fromMap({
      'styleupNo': styleupNo,
      'memNo': memNo,
      'parentStyleupCommentNo': parentStyleupCommentNo,
      'page': page
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) =>
              StyleupCommentModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future insertStyleupComment(styleupNo, memNo, parentStyleupCommentNo, detail,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/InsertStyleupComment';
    FormData formData = FormData.fromMap({
      'styleupNo': styleupNo,
      'memNo': memNo,
      'parentStyleupCommentNo': parentStyleupCommentNo,
      'detail': detail
    });

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future deleteStyleup(memNo, styleupNo, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/DeleteStyleup';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'styleupNo': styleupNo});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future deleteStyleupComment(memNo, styleupCommentNo,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/DeleteStyleupComment';
    FormData formData = FormData.fromMap(
        {'memNo': memNo, 'styleupCommentNo': styleupCommentNo});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future insertStyleupCommentReport(styleupCommentNo, memNo, reportTypeNo,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/InsertStyleupCommentReport';
    FormData formData = FormData.fromMap({
      'styleupCommentNo': styleupCommentNo,
      'memNo': memNo,
      'reportTypeNo': reportTypeNo
    });

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future styleupCommentHeart(styleupCommentNo, memNo, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/StyleupCommentHeart';
    FormData formData = FormData.fromMap(
        {'styleupCommentNo': styleupCommentNo, 'memNo': memNo});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future findPassword(
      email, Function(dynamic) success, Function(String) failure) async {
    const url = '/FindPassword';
    FormData formData = FormData.fromMap({
      'email': email,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getFollowStyleup(
      memNo,
      gender,
      height,
      weight,
      bodyShape,
      seasonIdList,
      styleIdList,
      sort,
      page,
      Function(List<StyleupModel>) success,
      Function(String) failure) async {
    const url = '/GetFollowStyleup';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'page': page, 'sort': sort});

    if (gender != null) {
      formData.fields.add(MapEntry('gender', gender));
    }
    if (height != null) {
      formData.fields.add(MapEntry('height', height));
    }
    if (weight != null) {
      formData.fields.add(MapEntry('weight', weight));
    }
    if (bodyShape != null) {
      formData.fields.add(MapEntry('bodyShape', bodyShape));
    }
    if (seasonIdList != null) {
      formData.fields.add(MapEntry('seasonIdList', seasonIdList));
    }
    if (styleIdList != null) {
      formData.fields.add(MapEntry('styleIdList', styleIdList));
    }

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StyleupModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getRecommendStyleup(
      memNo,
      gender,
      height,
      weight,
      bodyShape,
      seasonIdList,
      styleIdList,
      sort,
      page,
      Function(List<StyleupModel>) success,
      Function(String) failure) async {
    const url = '/GetRecommendStyleup';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'page': page, 'sort': sort});

    if (gender != null) {
      formData.fields.add(MapEntry('gender', gender));
    }
    if (height != null) {
      formData.fields.add(MapEntry('height', height));
    }
    if (weight != null) {
      formData.fields.add(MapEntry('weight', weight));
    }
    if (bodyShape != null) {
      formData.fields.add(MapEntry('bodyShape', bodyShape));
    }
    if (seasonIdList != null) {
      formData.fields.add(MapEntry('seasonIdList', seasonIdList));
    }
    if (styleIdList != null) {
      formData.fields.add(MapEntry('styleIdList', styleIdList));
    }

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StyleupModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future followUser(memNo, followMemNo, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/Follow';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'followMemNo': followMemNo});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future unFollowUser(memNo, followMemNo, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/Unfollow';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'followMemNo': followMemNo});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future styleupBookmark(styleupNo, memNo, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/StyleupBookmark';
    FormData formData =
        FormData.fromMap({'styleupNo': styleupNo, 'memNo': memNo});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getBannerList(memNo, type, Function(List<BannerModel>) success,
      Function(String) failure) async {
    const url = '/GetBannerList';
    FormData formData = FormData.fromMap({'memNo': memNo, 'type': type});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getGoodsStyleupList(
      memNo,
      goodsNo,
      page,
      Function(GetGoodsStyleupListModel) success,
      Function(String) failure) async {
    const url = '/GetGoodsStyleupList';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'goodsNo': goodsNo, 'page': page});

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          GetGoodsStyleupListModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getNetworkingList(memNo, Function(GetNetworkingListModel) success,
      Function(String) failure) async {
    const url = '/GetNetworkingList';
    FormData formData = FormData.fromMap({'memNo': memNo});

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          GetNetworkingListModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getMemberMinishopProductList(
      memNo,
      status,
      page,
      Function(List<MinishopProductModel>) success,
      Function(String) failure) async {
    const url = '/getMemberMinishopProduct';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'status': status, 'page': page});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) =>
              MinishopProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getMinishopProductList(
      memNo,
      keyword,
      productCategoryId,
      sort,
      minPrice,
      maxPrice,
      isNew,
      status,
      page,
      Function(List<MinishopProductModel>) success,
      Function(String) failure) async {
    const url = '/GetMinishopProductList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'keyword': keyword,
      'productCategoryId': productCategoryId,
      'sort': sort,
      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,
      'isNew': isNew,
      'status': status,
      'page': page,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) =>
              MinishopProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getMinishopProductReviewList(
      myMemno,
      memNo,
      page,
      Function(List<MinishopProductReviewModel>) success,
      Function(String) failure) async {
    const url = '/GetMemberMinishopProductReview';
    FormData formData =
        FormData.fromMap({'myMemNo': myMemno, 'memNo': memNo, 'page': page});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) =>
              MinishopProductReviewModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future insertStoreGoodsCart(memNo, goodsNo, options, goodsCnt,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/InsertStoreGoodsCart';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'goodsNo': goodsNo,
      'options': options,
      'goodsCnt': goodsCnt
    });

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future insertMinishopProduct(
      memNo,
      name,
      categoryId,
      price,
      deliveryPrice,
      viewSize,
      isNew,
      description,
      brand,
      actualSize,
      colorIdList,
      List<XFile> productImageList,
      List<XFile> wearImageList,
      Function(dynamic) success,
      Function(String) failure) async {
    const url = '/InsertMinishop';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'name': name,
      'categoryId': categoryId,
      'price': price,
      'deliveryPrice': deliveryPrice,
      'viewSize': viewSize,
      'isNew': isNew,
      'description': description,
      'brand': brand,
      'actualSize': actualSize,
      'colorIdList': colorIdList
    });

    int index = 0;
    for (var xfile in productImageList) {
      formData.files.add(
        MapEntry(
            "productImage$index", await MultipartFile.fromFile(xfile.path)),
      );
      index += 1;
    }

    index = 0;
    for (var xfile in wearImageList) {
      formData.files.add(
        MapEntry("wearImage$index", await MultipartFile.fromFile(xfile.path)),
      );
      index += 1;
    }

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getMinishopCategoryList(Function(List<MinishopCategoryModel>) success,
      Function(String) failure) async {
    const url = '/GetMinishopCategory';

    FormData formData = FormData.fromMap({});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) =>
              MinishopCategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getMinishopProductById(String memNo, String productId,
      Function(MinishopProductModel) success, Function(String) failure) async {
    const url = '/GetMinishopProductById';

    FormData formData =
        FormData.fromMap({'memNo': memNo, 'productId': productId});

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          MinishopProductModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getJoinStyleupList(memNo, page, limit,
      Function(List<StyleupModel>) success, Function(String) failure) async {
    const url = '/GetJoinStyleupList';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'page': page, 'limit': limit});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StyleupModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getJoinBattleStyleupList(memNo, page, limit,
      Function(List<StyleupModel>) success, Function(String) failure) async {
    const url = '/GetJoinBattleStyleupList';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'page': page, 'limit': limit});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StyleupModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future styleupUpDown(styleupNo, memNo, upDownType, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/StyleupUpDown';
    FormData formData = FormData.fromMap(
        {'styleupNo': styleupNo, 'memNo': memNo, 'upDownType': upDownType});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future heartGoods(memNo, goodsNo, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/HeartGoods';
    FormData formData = FormData.fromMap({'goodsNo': goodsNo});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future heartMinishopProduct(memNo, productId, isHeartOn,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/HeartMinishopProduct';
    FormData formData = FormData.fromMap(
        {'memNo': memNo, 'productId': productId, 'isHeartOn': isHeartOn});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getTerms(Function(String) success, Function(String) failure) async {
    const url = '/GetTerms';
    FormData formData = FormData.fromMap({});

    apiRequest('$baseUrl$url', formData, (data) {
      success(data);
    }, failure);
  }

  Future getPrivacy(Function(String) success, Function(String) failure) async {
    const url = '/GetPrivacy';
    FormData formData = FormData.fromMap({});

    apiRequest('$baseUrl$url', formData, (data) {
      success(data);
    }, failure);
  }

  Future getMarketing(
      Function(String) success, Function(String) failure) async {
    const url = '/GetMarketing';
    FormData formData = FormData.fromMap({});

    apiRequest('$baseUrl$url', formData, (data) {
      success(data);
    }, failure);
  }

  Future getMinishopProductHeartList(
      memNo,
      Function(List<MinishopProductModel>) success,
      Function(String) failure) async {
    const url = '/GetHeartMinishopProductList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) =>
              MinishopProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getGoodsHeartList(memNo, Function(List<StoreGoodModel>) success,
      Function(String) failure) async {
    const url = '/GetHeartGoodsList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StoreGoodModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future deleteHeartGoodsList(memNo, goodsIdList, Function(String) success,
      Function(String) failure) async {
    const url = '/DeleteHeartGoodsList';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'goodsIdList': goodsIdList});

    apiRequest('$baseUrl$url', formData, (data) {
      success(data);
    }, failure);
  }

  Future deleteHeartMinishopProductListController(memNo, productIdList,
      Function(String) success, Function(String) failure) async {
    const url = '/DeleteHeartMinishopProductList';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'productIdList': productIdList});

    apiRequest('$baseUrl$url', formData, (data) {
      success(data);
    }, failure);
  }

  Future getStoreRecentSearch(memNo, Function(RecentSearchListModel) success,
      Function(String) failure) async {
    const url = '/GetRecentStoreSearch';
    FormData formData = FormData.fromMap({"memNo": memNo});

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          RecentSearchListModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future deleteStoreRecentSearch(memNo, keyword, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/DeleteStoreRecentSearch';
    FormData formData = FormData.fromMap({'memNo': memNo, 'keyword': keyword});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getGoodsList(
      memNo,
      keyword,
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
      colorIdList,
      page,
      isRequest,
      Function(GoodsSearchResponseModel) success,
      Function(String) failure) async {
    const url = '/GetGoodsList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'keyword': keyword,
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'brandCd': brandCd,
      if (sort != null) 'sort': sort,
      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,
      if (styleIdList != null) 'styleIdList': styleIdList,
      if (fitIdList != null) 'fitIdList': fitIdList,
      if (materialIdList != null) 'materialIdList': materialIdList,
      if (flexibility != null) 'flexibility': flexibility,
      if (colorIdList != null) 'colorIdList': colorIdList,
      'page': page,
      'isRequest': isRequest
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          GoodsSearchResponseModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  /// new api

  Future getBattleInProductList(memNo, Function(List<StoreGoodModel>) success,
      Function(String) failure) async {
    const url = '/GetBattleInProductList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) => StoreGoodModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future getStoreGoodsReviewList(
      memNo,
      goodsNo,
      page,
      Function(GoodsReviewListResponseModel) success,
      Function(String) failure) async {
    const url = '/GetStoreGoodsReviewList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'goodsNo': goodsNo,
      'page': page,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          GoodsReviewListResponseModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getStoreGoodsQnaList(
      memNo,
      goodsNo,
      page,
      Function(GoodsQnaListResponseModel) success,
      Function(String) failure) async {
    const url = '/GetStoreGoodsQaList';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'goodsNo': goodsNo,
      'page': page,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result =
          GoodsQnaListResponseModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getGoodsDetail(memNo, goodsNo, Function(StoreGoodModel) success,
      Function(String) failure) async {
    const url = '/GetGoodsDetail';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'goodsNo': goodsNo,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = StoreGoodModel.fromJson(data as Map<String, dynamic>);
      success(result);
    }, failure);
  }

  Future getStoreGoodsQaCategory(
      memNo, Function(List<String>) success, Function(String) failure) async {
    const url = '/GetStoreGoodsQaPage';
    FormData formData = FormData.fromMap({'memNo': memNo});

    apiRequest('$baseUrl$url', formData, (data) {
      final result = List<String>.from(data);
      success(result);
    }, failure);
  }

  Future insertStoreQa(memNo, category, goodsNo, subject, content, isSecret,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/InsertStoreGoodsQa';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'category': category,
      'goodsNo': goodsNo,
      'subject': subject,
      'contents': content,
      'isSecret': isSecret
    });

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future registNewItemRequest(
      memNo,
      name,
      description,
      price,
      information,
      link,
      List<XFile> productImageList,
      Function() success,
      Function(String) failure) async {
    const url = '/GoodsItemRegistRequest';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
      'name': name,
      'description': description,
      'price': price,
      'information': information,
      'link': link,
    });

    int index = 0;
    for (var xfile in productImageList) {
      formData.files.add(
        MapEntry(
            "productImage$index", await MultipartFile.fromFile(xfile.path)),
      );
      index += 1;
    }

    apiRequest('$baseUrl$url', formData, (data) {
      success();
    }, failure);
  }

  Future viewMinishopProduct(memNo, productId, Function(dynamic) success,
      Function(String) failure) async {
    const url = '/ViewMinishopProduct';
    FormData formData =
        FormData.fromMap({'memNo': memNo, 'productId': productId});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  Future getRecentViewMinishopProduct(
      memNo,
      Function(List<MinishopProductModel>) success,
      Function(String) failure) async {
    const url = '/GetRecentViewMinishopProduct';
    FormData formData = FormData.fromMap({
      'memNo': memNo,
    });

    apiRequest('$baseUrl$url', formData, (data) {
      final result = (data as List<dynamic>)
          .map((item) =>
              MinishopProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
      success(result);
    }, failure);
  }

  Future updateMinishopProductStatus(memNo, productId, status,
      Function(dynamic) success, Function(String) failure) async {
    const url = '/UpdateMinishopProductStatus';

    FormData formData = FormData.fromMap(
        {'memNo': memNo, 'productId': productId, 'status': status});

    apiRequest('$baseUrl$url', formData, (data) {
      success(true);
    }, failure);
  }

  ///
}
