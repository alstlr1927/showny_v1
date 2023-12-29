import 'package:json_annotation/json_annotation.dart';

part 'styleup_percent_response.g.dart';

@JsonSerializable()
class StyleupPercentResponse {
  final bool success;
  final List<StyleupPercentData> data;

  StyleupPercentResponse({
    required this.success,
    required this.data,
  });

  factory StyleupPercentResponse.fromJson(Map<String, dynamic> json) =>
      _$StyleupPercentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StyleupPercentResponseToJson(this);
}

@JsonSerializable()
class StyleupPercentData {
  final String selectedStyleupNoPercent;
  final String otherStyleupNoPercent;

  StyleupPercentData({
    required this.selectedStyleupNoPercent,
    required this.otherStyleupNoPercent,
  });

  factory StyleupPercentData.fromJson(Map<String, dynamic> json) =>
      _$StyleupPercentDataFromJson(json);

  Map<String, dynamic> toJson() => _$StyleupPercentDataToJson(this);
}
