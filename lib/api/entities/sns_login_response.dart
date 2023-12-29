import 'package:json_annotation/json_annotation.dart';

part 'sns_login_response.g.dart';

@JsonSerializable()
class SnsLoginResponse {
  SnsLoginResponse({
    required this.success,
    this.data,
  });

  bool success;
  List<SLData>? data;

  factory SnsLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$SnsLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SnsLoginResponseToJson(this);
}

@JsonSerializable()
class SLData {
  SLData({
    required this.memId,
    required this.memNm,
    required this.gender,
    required this.birthday,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.heightId,
    required this.weightId,
    required this.bodyShapeId,
    required this.styleIdList,
    required this.colorIdList,
  });

  String memId;
  String memNm;
  int gender;
  bool birthday;
  String email;
  String phone;
  String profileImage;
  int heightId;
  int weightId;
  int bodyShapeId;
  bool styleIdList;
  bool colorIdList;

  factory SLData.fromJson(Map<String, dynamic> json) => _$SLDataFromJson(json);

  Map<String, dynamic> toJson() => _$SLDataToJson(this);
}
