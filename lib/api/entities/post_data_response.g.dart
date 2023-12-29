// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDataResponse _$PostDataResponseFromJson(Map<String, dynamic> json) =>
    PostDataResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => STUData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostDataResponseToJson(PostDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
