// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SNUser _$SNUserFromJson(Map<String, dynamic> json) => SNUser(
      memNo: json['memNo'] as String,
      memId: json['memId'] as String?,
      memNm: json['memNm'] as String,
      nickNm: json['nickNm'] as String?,
      gender: json['gender'] as int,
      birthday: json['birthday'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profileImage: json['profileImage'] as String?,
      introduce: json['introduce'] as String?,
      heightId: json['heightId'] as int?,
      weightId: json['weightId'] as int?,
      bodyShapeId: json['bodyShapeId'] as int?,
      styleIdList: (json['styleIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      colorIdList: (json['colorIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      postCount: json['postCount'] as int?,
      followerCount: json['followerCount'] as int?,
      followCount: json['followCount'] as int?,
      isFollow: json['isFollow'] as bool?,
      
    );

Map<String, dynamic> _$SNUserToJson(SNUser instance) => <String, dynamic>{
      'memNo': instance.memNo,
      'memId': instance.memId,
      'memNm': instance.memNm,
      'nickNm': instance.nickNm,
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
      'isFollow': instance.isFollow
    };
