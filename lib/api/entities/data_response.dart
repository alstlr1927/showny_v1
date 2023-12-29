import 'package:json_annotation/json_annotation.dart';

part 'data_response.g.dart';

@JsonSerializable()
class DataResponse {
  DataResponse({
    required this.success,
    this.data,
  });

  bool success;
  List<SNData>? data;

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class SNData {
  SNData({
    required this.id,
    required this.value,
  });

  String id;
  String value;

  factory SNData.fromJson(Map<String, dynamic> json) => _$SNDataFromJson(json);

  Map<String, dynamic> toJson() => _$SNDataToJson(this);
}
