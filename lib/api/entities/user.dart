import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class SNUser {
  SNUser({
    required this.memNo,
    this.memId,
    required this.memNm,
    this.nickNm,
    required this.gender,
    this.birthday,
    required this.email,
    required this.phone,
    this.profileImage,
    this.introduce,
    this.heightId,
    this.weightId,
    this.bodyShapeId,
    this.styleIdList,
    this.colorIdList,
    this.postCount,
    this.followerCount,
    this.followCount,
    this.isFollow
  });

  String memNo;
  String? memId;
  String memNm;
  String? nickNm;
  int gender;
  String? birthday;
  String email;
  String phone;
  String? profileImage;
  String? introduce;
  int? heightId;
  int? weightId;
  int? bodyShapeId;
  List<int>? styleIdList;
  List<int>? colorIdList;
  int? postCount;
  int? followerCount;
  int? followCount;
  bool? isFollow;

  factory SNUser.fromJson(Map<String, dynamic> json) => _$SNUserFromJson(json);

  Map<String, dynamic> toJson() => _$SNUserToJson(this);
}
