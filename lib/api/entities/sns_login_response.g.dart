// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sns_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnsLoginResponse _$SnsLoginResponseFromJson(Map<String, dynamic> json) =>
    SnsLoginResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SLData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SnsLoginResponseToJson(SnsLoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

SLData _$SLDataFromJson(Map<String, dynamic> json) => SLData(
      memId: json['memId'] as String,
      memNm: json['memNm'] as String,
      gender: json['gender'] as int,
      birthday: json['birthday'] as bool,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profileImage: json['profileImage'] as String,
      heightId: json['heightId'] as int,
      weightId: json['weightId'] as int,
      bodyShapeId: json['bodyShapeId'] as int,
      styleIdList: json['styleIdList'] as bool,
      colorIdList: json['colorIdList'] as bool,
    );

Map<String, dynamic> _$SLDataToJson(SLData instance) => <String, dynamic>{
      'memId': instance.memId,
      'memNm': instance.memNm,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'heightId': instance.heightId,
      'weightId': instance.weightId,
      'bodyShapeId': instance.bodyShapeId,
      'styleIdList': instance.styleIdList,
      'colorIdList': instance.colorIdList,
    };
