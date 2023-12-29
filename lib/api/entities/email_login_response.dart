import 'package:json_annotation/json_annotation.dart';
import 'package:showny/api/entities/user.dart';

part 'email_login_response.g.dart';

@JsonSerializable()
class EmailLoginResponse {
  EmailLoginResponse({
    required this.success,
    this.data,
  });

  bool success;
  SNUser? data;

  factory EmailLoginResponse.fromJson(Map<String, dynamic> json) => _$EmailLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmailLoginResponseToJson(this);
}
