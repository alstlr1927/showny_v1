// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SNData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

SNData _$SNDataFromJson(Map<String, dynamic> json) => SNData(
      id: json['id'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$SNDataToJson(SNData instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
