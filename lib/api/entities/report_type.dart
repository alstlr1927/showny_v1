import 'package:json_annotation/json_annotation.dart';

part 'report_type.g.dart';

@JsonSerializable()
class ReportTypeResponse {
  ReportTypeResponse({
    required this.success,
    required this.data,
  });

  bool success;
  ReportTypeData data;

  factory ReportTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportTypeResponseToJson(this);
}

@JsonSerializable()
class ReportTypeData {
  ReportTypeData({
    required this.reportType,
  });

  List<ReportType> reportType;

  factory ReportTypeData.fromJson(Map<String, dynamic> json) =>
      _$ReportTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportTypeDataToJson(this);
}

@JsonSerializable()
class ReportType {
  ReportType({
    required this.title,
    required this.description,
  });

  String title;
  String description;

  factory ReportType.fromJson(Map<String, dynamic> json) =>
      _$ReportTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReportTypeToJson(this);
}
