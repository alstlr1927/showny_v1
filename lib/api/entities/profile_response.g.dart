// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      userData: json['userData'] == null
          ? null
          : UserData.fromJson(json['userData'] as Map<String, dynamic>),
      postData: (json['postData'] as List<dynamic>?)
          ?.map((e) => PostData.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookmarkData: (json['bookmarkData'] as List<dynamic>?)
          ?.map((e) => BookmarkData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'userData': instance.userData,
      'postData': instance.postData,
      'bookmarkData': instance.bookmarkData,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      memNo: json['memNo'] as String,
      memId: json['memId'] as String,
      memNm: json['memNm'] as String,
      gender: json['gender'] as int,
      birthday: json['birthday'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profileImage: json['profileImage'] as String,
      introduce: json['introduce'] as String,
      heightId: json['heightId'] as int,
      weightId: json['weightId'] as int,
      bodyShapeId: json['bodyShapeId'] as int,
      styleIdList:
          (json['styleIdList'] as List<dynamic>).map((e) => e as int).toList(),
      colorIdList:
          (json['colorIdList'] as List<dynamic>).map((e) => e as int).toList(),
      postCount: json['postCount'] as String,
      followerCount: json['followerCount'] as int,
      followCount: json['followCount'] as int,
      isFollow: json['isFollow'] as bool,
      postData: (json['postData'] as List<dynamic>?)
          ?.map((e) => PostData.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookmarkData: (json['bookmarkData'] as List<dynamic>?)
          ?.map((e) => BookmarkData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'memNo': instance.memNo,
      'memId': instance.memId,
      'memNm': instance.memNm,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'introduce': instance.introduce,
      'heightId': instance.heightId,
      'weightId': instance.weightId,
      'bodyShapeId': instance.bodyShapeId,
      'styleIdList': instance.styleIdList,
      'colorIdList': instance.colorIdList,
      'postCount': instance.postCount,
      'followerCount': instance.followerCount,
      'followCount': instance.followCount,
      'isFollow': instance.isFollow,
      'postData': instance.postData,
      'bookmarkData': instance.bookmarkData,
    };

PostData _$PostDataFromJson(Map<String, dynamic> json) => PostData(
      styleupNo: json['styleupNo'] as String,
      type: json['type'] as String,
      imgUrlList: (json['imgUrlList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$PostDataToJson(PostData instance) => <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'type': instance.type,
      'imgUrlList': instance.imgUrlList,
      'thumbnailUrl': instance.thumbnailUrl,
    };

BookmarkData _$BookmarkDataFromJson(Map<String, dynamic> json) => BookmarkData(
      styleupNo: json['styleupNo'] as String,
      type: json['type'] as String,
      imgUrlList: (json['imgUrlList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$BookmarkDataToJson(BookmarkData instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'type': instance.type,
      'imgUrlList': instance.imgUrlList,
      'thumbnailUrl': instance.thumbnailUrl,
    };
