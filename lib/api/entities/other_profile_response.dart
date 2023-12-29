import 'package:json_annotation/json_annotation.dart';

part 'other_profile_response.g.dart';

@JsonSerializable()
class OtherProfileResponse {
  final bool success;
  final UserData data;

  OtherProfileResponse({
    required this.success,
    required this.data,
  });

  factory OtherProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$OtherProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtherProfileResponseToJson(this);
}

@JsonSerializable()
class UserData {
  final String memNo;
  final String memId;
  final String memNm;
  final int gender;
  final String birthday;
  final String email;
  final String phone;
  final String profileImage;
  final String introduce;
  final int heightId;
  final int weightId;
  final int bodyShapeId;
  final List<int> styleIdList;
  final List<int> colorIdList;
  final String postCount;
  final int followerCount;
  final int followCount;
  final bool isFollow;

  UserData({
    required this.memNo,
    required this.memId,
    required this.memNm,
    required this.gender,
    required this.birthday,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.introduce,
    required this.heightId,
    required this.weightId,
    required this.bodyShapeId,
    required this.styleIdList,
    required this.colorIdList,
    required this.postCount,
    required this.followerCount,
    required this.followCount,
    required this.isFollow,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
