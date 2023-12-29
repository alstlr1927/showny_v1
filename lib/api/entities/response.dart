import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class SNResponse {
  SNResponse({
    required this.success,
    this.data,
    this.error,
  });

  bool success;
  dynamic data;
  String? error;

  factory SNResponse.fromJson(Map<String, dynamic> json) {
    return SNResponse(
      success: json['success'] ?? false,
      data: json['data'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() => _$SNResponseToJson(this);
}
