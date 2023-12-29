import 'package:json_annotation/json_annotation.dart';

part 'user_data_response.g.dart';

@JsonSerializable()
class UserDataResponse {
  final bool success;
  final UserDataResponseData data;

  UserDataResponse({
    required this.success,
    required this.data,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class UserDataResponseData {
  final List<UserData> userData;
  final int totalCount;

  UserDataResponseData({
    required this.userData,
    required this.totalCount,
  });

  factory UserDataResponseData.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseDataToJson(this);
}

@JsonSerializable()
class UserData {
  final String memNo;
  final String? nickNm;
  final String postCount;
  final String followCount;
  final String followerCount;
  final bool isFollow;

  UserData({
    required this.memNo,
    this.nickNm,
    required this.postCount,
    required this.followCount,
    required this.followerCount,
    required this.isFollow,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
