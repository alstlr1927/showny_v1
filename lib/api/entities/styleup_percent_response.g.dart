// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'styleup_percent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleupPercentResponse _$StyleupPercentResponseFromJson(
        Map<String, dynamic> json) =>
    StyleupPercentResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => StyleupPercentData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StyleupPercentResponseToJson(
        StyleupPercentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

StyleupPercentData _$StyleupPercentDataFromJson(Map<String, dynamic> json) =>
    StyleupPercentData(
      selectedStyleupNoPercent: json['selectedStyleupNoPercent'] as String,
      otherStyleupNoPercent: json['otherStyleupNoPercent'] as String,
    );

Map<String, dynamic> _$StyleupPercentDataToJson(StyleupPercentData instance) =>
    <String, dynamic>{
      'selectedStyleupNoPercent': instance.selectedStyleupNoPercent,
      'otherStyleupNoPercent': instance.otherStyleupNoPercent,
    };
