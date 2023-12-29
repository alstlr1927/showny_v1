// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowResponse _$FollowResponseFromJson(Map<String, dynamic> json) =>
    FollowResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => FollowData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FollowResponseToJson(FollowResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

FollowData _$FollowDataFromJson(Map<String, dynamic> json) => FollowData(
      followMemNo: json['followMemNo'] as String,
      isFollow: json['isFollow'] as bool,
    );

Map<String, dynamic> _$FollowDataToJson(FollowData instance) =>
    <String, dynamic>{
      'followMemNo': instance.followMemNo,
      'isFollow': instance.isFollow,
    };
