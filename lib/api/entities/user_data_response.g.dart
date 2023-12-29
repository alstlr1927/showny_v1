// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      success: json['success'] as bool,
      data: UserDataResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

UserDataResponseData _$UserDataResponseDataFromJson(
        Map<String, dynamic> json) =>
    UserDataResponseData(
      userData: (json['userData'] as List<dynamic>)
          .map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
    );

Map<String, dynamic> _$UserDataResponseDataToJson(
        UserDataResponseData instance) =>
    <String, dynamic>{
      'userData': instance.userData,
      'totalCount': instance.totalCount,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      memNo: json['memNo'] as String,
      nickNm: json['nickNm'] as String?,
      postCount: json['postCount'] as String,
      followCount: json['followCount'] as String,
      followerCount: json['followerCount'] as String,
      isFollow: json['isFollow'] as bool,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'memNo': instance.memNo,
      'nickNm': instance.nickNm,
      'postCount': instance.postCount,
      'followCount': instance.followCount,
      'followerCount': instance.followerCount,
      'isFollow': instance.isFollow,
    };
