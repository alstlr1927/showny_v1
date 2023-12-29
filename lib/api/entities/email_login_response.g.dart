// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailLoginResponse _$EmailLoginResponseFromJson(Map<String, dynamic> json) =>
    EmailLoginResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : SNUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmailLoginResponseToJson(EmailLoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
