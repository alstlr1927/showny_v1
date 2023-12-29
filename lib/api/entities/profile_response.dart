import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  final bool success;
  final ProfileData? data;

  ProfileResponse({
    required this.success,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class ProfileData {
  final UserData? userData;
  final List<PostData>? postData;
  final List<BookmarkData>? bookmarkData;

  ProfileData({
    this.userData,
    this.postData,
    this.bookmarkData,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
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
  final List<PostData>? postData;
  final List<BookmarkData>? bookmarkData;

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
    this.postData,
    this.bookmarkData,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class PostData {
  final String styleupNo;
  final String type;
  final List<String>? imgUrlList;
  final String thumbnailUrl;

  PostData({
    required this.styleupNo,
    required this.type,
    this.imgUrlList,
    required this.thumbnailUrl,
  });

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}

@JsonSerializable()
class BookmarkData {
  final String styleupNo;
  final String type;
  final List<String>? imgUrlList;
  final String thumbnailUrl;

  BookmarkData({
    required this.styleupNo,
    required this.type,
    this.imgUrlList,
    required this.thumbnailUrl,
  });

  factory BookmarkData.fromJson(Map<String, dynamic> json) =>
      _$BookmarkDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkDataToJson(this);
}
