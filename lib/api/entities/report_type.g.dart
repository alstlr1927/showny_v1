// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportTypeResponse _$ReportTypeResponseFromJson(Map<String, dynamic> json) =>
    ReportTypeResponse(
      success: json['success'] as bool,
      data: ReportTypeData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportTypeResponseToJson(ReportTypeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

ReportTypeData _$ReportTypeDataFromJson(Map<String, dynamic> json) =>
    ReportTypeData(
      reportType: (json['reportType'] as List<dynamic>)
          .map((e) => ReportType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportTypeDataToJson(ReportTypeData instance) =>
    <String, dynamic>{
      'reportType': instance.reportType,
    };

ReportType _$ReportTypeFromJson(Map<String, dynamic> json) => ReportType(
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ReportTypeToJson(ReportType instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };
