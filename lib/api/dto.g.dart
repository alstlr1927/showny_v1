// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPhoneNumberSendDto _$VerifyPhoneNumberSendDtoFromJson(
        Map<String, dynamic> json) =>
    VerifyPhoneNumberSendDto(
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$VerifyPhoneNumberSendDtoToJson(
        VerifyPhoneNumberSendDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };

VerifyPhoneNumberDto _$VerifyPhoneNumberDtoFromJson(
        Map<String, dynamic> json) =>
    VerifyPhoneNumberDto(
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      verifyCode: json['verifyCode'] as String,
    );

Map<String, dynamic> _$VerifyPhoneNumberDtoToJson(
        VerifyPhoneNumberDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'verifyCode': instance.verifyCode,
    };

CheckDuplicateEmailDto _$CheckDuplicateEmailDtoFromJson(
        Map<String, dynamic> json) =>
    CheckDuplicateEmailDto(
      email: json['email'] as String,
    );

Map<String, dynamic> _$CheckDuplicateEmailDtoToJson(
        CheckDuplicateEmailDto instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

CheckDuplicateIdDto _$CheckDuplicateIdDtoFromJson(Map<String, dynamic> json) =>
    CheckDuplicateIdDto(
      memId: json['memId'] as String,
    );

Map<String, dynamic> _$CheckDuplicateIdDtoToJson(
        CheckDuplicateIdDto instance) =>
    <String, dynamic>{
      'memId': instance.memId,
    };

SignupEmailDto _$SignupEmailDtoFromJson(Map<String, dynamic> json) =>
    SignupEmailDto(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      marketingAgree: json['marketingAgree'] as String,
    );

Map<String, dynamic> _$SignupEmailDtoToJson(SignupEmailDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'marketingAgree': instance.marketingAgree,
    };

SignupSnsDto _$SignupSnsDtoFromJson(Map<String, dynamic> json) => SignupSnsDto(
      snsType: json['snsType'] as String,
      snsId: json['snsId'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      marketingAgree: json['marketingAgree'] as String,
    );

Map<String, dynamic> _$SignupSnsDtoToJson(SignupSnsDto instance) =>
    <String, dynamic>{
      'snsType': instance.snsType,
      'snsId': instance.snsId,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'marketingAgree': instance.marketingAgree,
    };

SigninEmailDto _$SigninEmailDtoFromJson(Map<String, dynamic> json) =>
    SigninEmailDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SigninEmailDtoToJson(SigninEmailDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

SigninSnsDto _$SigninSnsDtoFromJson(Map<String, dynamic> json) => SigninSnsDto(
      snsType: json['snsType'] as String,
      snsId: json['snsId'] as String,
    );

Map<String, dynamic> _$SigninSnsDtoToJson(SigninSnsDto instance) =>
    <String, dynamic>{
      'snsType': instance.snsType,
      'snsId': instance.snsId,
    };

ProfileEditDto _$ProfileEditDtoFromJson(Map<String, dynamic> json) =>
    ProfileEditDto(
      memNo: json['memNo'] as String,
      gender: json['gender'] as int?,
      newMemId: json['newMemId'] as String?,
      birthday: json['birthday'] as String?,
      heightId: json['heightId'] as String?,
      weightId: json['weightId'] as String?,
      bodyShapeId: json['bodyShapeId'] as String?,
      styleIdList: json['styleIdList'] as String?,
      colorIdList: json['colorIdList'] as String?,
      password: json['password'] as String?,
      newPassword: json['newPassword'] as String?,
      introduce: json['introduce'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$ProfileEditDtoToJson(ProfileEditDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'gender': instance.gender,
      'newMemId': instance.newMemId,
      'birthday': instance.birthday,
      'heightId': instance.heightId,
      'weightId': instance.weightId,
      'bodyShapeId': instance.bodyShapeId,
      'styleIdList': instance.styleIdList,
      'colorIdList': instance.colorIdList,
      'password': instance.password,
      'newPassword': instance.newPassword,
      'introduce': instance.introduce,
      'phoneNumber': instance.phoneNumber,
    };

GetProfileDto _$GetProfileDtoFromJson(Map<String, dynamic> json) =>
    GetProfileDto(
      memNo: json['memNo'] as String,
    );

Map<String, dynamic> _$GetProfileDtoToJson(GetProfileDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
    };

FindPasswordDto _$FindPasswordDtoFromJson(Map<String, dynamic> json) =>
    FindPasswordDto(
      email: json['email'] as String,
    );

Map<String, dynamic> _$FindPasswordDtoToJson(FindPasswordDto instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

UserFollowDto _$UserFollowDtoFromJson(Map<String, dynamic> json) =>
    UserFollowDto(
      memNo: json['memNo'] as String,
      followMemNo: json['followMemNo'] as String,
    );

Map<String, dynamic> _$UserFollowDtoToJson(UserFollowDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'followMemNo': instance.followMemNo,
    };

InsertStyleupDto _$InsertStyleupDtoFromJson(Map<String, dynamic> json) =>
    InsertStyleupDto(
      memNo: json['memNo'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      styles:
          (json['styles'] as List<dynamic>).map((e) => e as String).toList(),
      colors:
          (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      season: json['season'] as String,
      itemOuter: (json['itemOuter'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      itemTop: (json['itemTop'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      itemPants: (json['itemPants'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      itemShoes: (json['itemShoes'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      itemBag: (json['itemBag'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      itemAccessory: (json['itemAccessory'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      imgUrlList: (json['imgUrlList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$InsertStyleupDtoToJson(InsertStyleupDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'type': instance.type,
      'imgUrlList': instance.imgUrlList,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'styles': instance.styles,
      'colors': instance.colors,
      'season': instance.season,
      'itemOuter': instance.itemOuter,
      'itemTop': instance.itemTop,
      'itemPants': instance.itemPants,
      'itemShoes': instance.itemShoes,
      'itemBag': instance.itemBag,
      'itemAccessory': instance.itemAccessory,
    };

GetStyleupListDto _$GetStyleupListDtoFromJson(Map<String, dynamic> json) =>
    GetStyleupListDto(
      memNo: json['memNo'] as String,
      page: json['page'] as String,
      connectTime: json['connectTime'] as String,
    );

Map<String, dynamic> _$GetStyleupListDtoToJson(GetStyleupListDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'page': instance.page,
      'connectTime': instance.connectTime,
    };

DeleteStyleupDto _$DeleteStyleupDtoFromJson(Map<String, dynamic> json) =>
    DeleteStyleupDto(
      styleupNo: json['styleupNo'] as String,
    );

Map<String, dynamic> _$DeleteStyleupDtoToJson(DeleteStyleupDto instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
    };

GetWearingListDto _$GetWearingListDtoFromJson(Map<String, dynamic> json) =>
    GetWearingListDto(
      styleupNo: json['styleupNo'] as String,
      arrayNo: json['arrayNo'] as String,
    );

Map<String, dynamic> _$GetWearingListDtoToJson(GetWearingListDto instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'arrayNo': instance.arrayNo,
    };

InsertStyleupReportDto _$InsertStyleupReportDtoFromJson(
        Map<String, dynamic> json) =>
    InsertStyleupReportDto(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
      reportTypeNo: json['reportTypeNo'] as int,
    );

Map<String, dynamic> _$InsertStyleupReportDtoToJson(
        InsertStyleupReportDto instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'memNo': instance.memNo,
      'reportTypeNo': instance.reportTypeNo,
    };

InsertStyleupCommentDto _$InsertStyleupCommentDtoFromJson(
        Map<String, dynamic> json) =>
    InsertStyleupCommentDto(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
      parentStyleupCommentNo: json['parentStyleupCommentNo'] as String?,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$InsertStyleupCommentDtoToJson(
        InsertStyleupCommentDto instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'memNo': instance.memNo,
      'parentStyleupCommentNo': instance.parentStyleupCommentNo,
      'detail': instance.detail,
    };

DeleteStyleupCommentDto _$DeleteStyleupCommentDtoFromJson(
        Map<String, dynamic> json) =>
    DeleteStyleupCommentDto(
      memNo: json['memNo'] as String,
      styleupCommentNo: json['styleupCommentNo'] as String,
    );

Map<String, dynamic> _$DeleteStyleupCommentDtoToJson(
        DeleteStyleupCommentDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'styleupCommentNo': instance.styleupCommentNo,
    };

StyleupCommentHeartDto _$StyleupCommentHeartDtoFromJson(
        Map<String, dynamic> json) =>
    StyleupCommentHeartDto(
      styleupCommentNo: json['styleupCommentNo'] as String,
      memNo: json['memNo'] as String,
    );

Map<String, dynamic> _$StyleupCommentHeartDtoToJson(
        StyleupCommentHeartDto instance) =>
    <String, dynamic>{
      'styleupCommentNo': instance.styleupCommentNo,
      'memNo': instance.memNo,
    };

GetStyleupCommentListDto _$GetStyleupCommentListDtoFromJson(
        Map<String, dynamic> json) =>
    GetStyleupCommentListDto(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
      page: json['page'] as String,
      connectTime: json['connectTime'] as String,
    );

Map<String, dynamic> _$GetStyleupCommentListDtoToJson(
        GetStyleupCommentListDto instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'memNo': instance.memNo,
      'page': instance.page,
      'connectTime': instance.connectTime,
    };

StyleupBookmarkDto _$StyleupBookmarkDtoFromJson(Map<String, dynamic> json) =>
    StyleupBookmarkDto(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
    );

Map<String, dynamic> _$StyleupBookmarkDtoToJson(StyleupBookmarkDto instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'memNo': instance.memNo,
    };

StyleupUpDownDto _$StyleupUpDownDtoFromJson(Map<String, dynamic> json) =>
    StyleupUpDownDto(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
      upDownType: json['upDownType'] as int,
    );

Map<String, dynamic> _$StyleupUpDownDtoToJson(StyleupUpDownDto instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'memNo': instance.memNo,
      'upDownType': instance.upDownType,
    };

InsertStyleupBattleDto _$InsertStyleupBattleDtoFromJson(
        Map<String, dynamic> json) =>
    InsertStyleupBattleDto(
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      recruitmentStart: json['recruitmentStart'] as String,
      recruitmentEnd: json['recruitmentEnd'] as String,
      participationStart: json['participationStart'] as String,
      participationEnd: json['participationEnd'] as String,
      round: json['round'] as String,
    );

Map<String, dynamic> _$InsertStyleupBattleDtoToJson(
        InsertStyleupBattleDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'recruitmentStart': instance.recruitmentStart,
      'recruitmentEnd': instance.recruitmentEnd,
      'participationStart': instance.participationStart,
      'participationEnd': instance.participationEnd,
      'round': instance.round,
    };

GetMyStyleupListDto _$GetMyStyleupListDtoFromJson(Map<String, dynamic> json) =>
    GetMyStyleupListDto(
      memNo: json['memNo'] as String,
      page: json['page'] as String,
      connectTime: json['connectTime'] as String,
    );

Map<String, dynamic> _$GetMyStyleupListDtoToJson(
        GetMyStyleupListDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'page': instance.page,
      'connectTime': instance.connectTime,
    };

InsertStyleupBattleParticipationDto
    _$InsertStyleupBattleParticipationDtoFromJson(Map<String, dynamic> json) =>
        InsertStyleupBattleParticipationDto(
          styleupBattleNo: json['styleupBattleNo'] as String,
          styleupNo: json['styleupNo'] as String,
          memNo: json['memNo'] as String,
        );

Map<String, dynamic> _$InsertStyleupBattleParticipationDtoToJson(
        InsertStyleupBattleParticipationDto instance) =>
    <String, dynamic>{
      'styleupBattleNo': instance.styleupBattleNo,
      'styleupNo': instance.styleupNo,
      'memNo': instance.memNo,
    };

InsertStyleupCommentReportDto _$InsertStyleupCommentReportDtoFromJson(
        Map<String, dynamic> json) =>
    InsertStyleupCommentReportDto(
      styleupCommentNo: json['styleupCommentNo'] as int,
      memNo: json['memNo'] as int,
      reportTypeNo: json['reportTypeNo'] as int,
    );

Map<String, dynamic> _$InsertStyleupCommentReportDtoToJson(
        InsertStyleupCommentReportDto instance) =>
    <String, dynamic>{
      'styleupCommentNo': instance.styleupCommentNo,
      'memNo': instance.memNo,
      'reportTypeNo': instance.reportTypeNo,
    };

GetStyleupBattleItemListDto _$GetStyleupBattleItemListDtoFromJson(
        Map<String, dynamic> json) =>
    GetStyleupBattleItemListDto(
      styleupBattleNo: json['styleupBattleNo'] as String?,
      memNo: json['memNo'] as String,
    );

Map<String, dynamic> _$GetStyleupBattleItemListDtoToJson(
        GetStyleupBattleItemListDto instance) =>
    <String, dynamic>{
      'styleupBattleNo': instance.styleupBattleNo,
      'memNo': instance.memNo,
    };

SelectStyleupBattleItemDto _$SelectStyleupBattleItemDtoFromJson(
        Map<String, dynamic> json) =>
    SelectStyleupBattleItemDto(
      battleRoundNo: json['battleRoundNo'] as String,
      selectedStyleupNo: json['selectedStyleupNo'] as String,
      otherStyleupNo: json['otherStyleupNo'] as String,
      memNo: json['memNo'] as String,
    );

Map<String, dynamic> _$SelectStyleupBattleItemDtoToJson(
        SelectStyleupBattleItemDto instance) =>
    <String, dynamic>{
      'battleRoundNo': instance.battleRoundNo,
      'selectedStyleupNo': instance.selectedStyleupNo,
      'otherStyleupNo': instance.otherStyleupNo,
      'memNo': instance.memNo,
    };

GetFollowStyleupDto _$GetFollowStyleupDtoFromJson(Map<String, dynamic> json) =>
    GetFollowStyleupDto(
      memNo: json['memNo'] as String,
      gender: json['gender'] as String?,
      height:
          (json['height'] as List<dynamic>?)?.map((e) => e as String).toList(),
      weight:
          (json['weight'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bodyShapeId: (json['bodyShapeId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      seasonIdList: (json['seasonIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      styleIdList: (json['styleIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sort: json['sort'] as String,
      page: json['page'] as String,
      connectTime: json['connectTime'] as String
    );

Map<String, dynamic> _$GetFollowStyleupDtoToJson(
        GetFollowStyleupDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'gender': instance.gender,
      'height': instance.height,
      'weight': instance.weight,
      'bodyShapeId': instance.bodyShapeId,
      'seasonIdList': instance.seasonIdList,
      'styleIdList': instance.styleIdList,
    };

GetRecommendStyleupDto _$GetRecommendStyleupDtoFromJson(
        Map<String, dynamic> json) =>
    GetRecommendStyleupDto(
      memNo: json['memNo'] as String,
      gender: json['gender'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      bodyShapeId: json['bodyShapeId'] as String?,
      seasonIdList: json['seasonIdList'] as String?,
      styleIdList: json['styleIdList'] as String?,
      sort: json['sort'] as String,
      page: json['page'] as String,
      connectTime: json['connectTime'] as String,
    );

Map<String, dynamic> _$GetRecommendStyleupDtoToJson(
        GetRecommendStyleupDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'gender': instance.gender,
      'height': instance.height,
      'weight': instance.weight,
      'bodyShapeId': instance.bodyShapeId,
      'seasonIdList': instance.seasonIdList,
      'styleIdList': instance.styleIdList,
      'sort': instance.sort,
      'page': instance.page,
      'connectTime': instance.connectTime,
    };

GetRankingStyleupDto _$GetRankingStyleupDtoFromJson(
        Map<String, dynamic> json) =>
    GetRankingStyleupDto(
      memNo: json['memNo'] as String,
    );

Map<String, dynamic> _$GetRankingStyleupDtoToJson(
        GetRankingStyleupDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
    };

SearchUserDto _$SearchUserDtoFromJson(Map<String, dynamic> json) =>
    SearchUserDto(
      memNo: json['memNo'] as String,
      keyword: json['keyword'] as String,
      page: json['page'] as String,
      connectTime: json['connectTime'] as String,
    );

Map<String, dynamic> _$SearchUserDtoToJson(SearchUserDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'keyword': instance.keyword,
      'page': instance.page,
      'connectTime': instance.connectTime,
    };

SearchPostDto _$SearchPostDtoFromJson(Map<String, dynamic> json) =>
    SearchPostDto(
      memNo: json['memNo'] as String,
      keyword: json['keyword'] as String,
      page: json['page'] as String,
      connectTime: json['connectTime'] as String,
    );

Map<String, dynamic> _$SearchPostDtoToJson(SearchPostDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'keyword': instance.keyword,
      'page': instance.page,
      'connectTime': instance.connectTime,
    };

GetRecentSearchDto _$GetRecentSearchDtoFromJson(Map<String, dynamic> json) =>
    GetRecentSearchDto(
      memNo: json['memNo'] as String,
    );

Map<String, dynamic> _$GetRecentSearchDtoToJson(GetRecentSearchDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
    };

GetBannerListDto _$GetBannerListDtoFromJson(Map<String, dynamic> json) =>
    GetBannerListDto(
      memNo: json['memNo'] as String,
    );

Map<String, dynamic> _$GetBannerListDtoToJson(GetBannerListDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
    };

GetFollowListDto _$GetFollowListDtoFromJson(Map<String, dynamic> json) =>
    GetFollowListDto(
      memNo: json['memNo'] as String,
      profileMemNo: json['profileMemNo'] as String,
    );

Map<String, dynamic> _$GetFollowListDtoToJson(GetFollowListDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'profileMemNo': instance.profileMemNo,
    };

GetOtherProfileControllerDto _$GetOtherProfileControllerDtoFromJson(
        Map<String, dynamic> json) =>
    GetOtherProfileControllerDto(
      memNo: json['memNo'] as String,
      profileMemNo: json['profileMemNo'] as String,
    );

Map<String, dynamic> _$GetOtherProfileControllerDtoToJson(
        GetOtherProfileControllerDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'profileMemNo': instance.profileMemNo,
    };

GetStyleupBattleListDto _$GetStyleupBattleListDtoFromJson(
        Map<String, dynamic> json) =>
    GetStyleupBattleListDto(
      memNo: json['memNo'] as String,
      keyword: json['keyword'] as String?,
    );

Map<String, dynamic> _$GetStyleupBattleListDtoToJson(
        GetStyleupBattleListDto instance) =>
    <String, dynamic>{
      'memNo': instance.memNo,
      'keyword': instance.keyword,
    };
