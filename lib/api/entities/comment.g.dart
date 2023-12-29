// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CommentData.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'error': instance.error,
    };

CommentData _$CommentDataFromJson(Map<String, dynamic> json) => CommentData(
      styleupCommentNo: json['styleupCommentNo'] as String?,
      memNo: json['memNo'] as String?,
      profileImage: json['profileImage'] as String?,
      nickNm: json['nickNm'] as String?,
      detail: json['detail'] as String?,
      isHeart: json['isHeart'] as bool?,
      heartCount: json['heartCount'] as int?,
      created_at: json['created_at'] as String?,
      childCommenList: (json['childCommenList'] as List<dynamic>?)
          ?.map((e) => ChildComment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentDataToJson(CommentData instance) =>
    <String, dynamic>{
      'styleupCommentNo': instance.styleupCommentNo,
      'memNo': instance.memNo,
      'profileImage': instance.profileImage,
      'nickNm': instance.nickNm,
      'detail': instance.detail,
      'isHeart': instance.isHeart,
      'heartCount': instance.heartCount,
      'created_at': instance.created_at,
      'childCommenList': instance.childCommenList,
    };

ChildComment _$ChildCommentFromJson(Map<String, dynamic> json) => ChildComment(
      styleupCommentNo: json['styleupCommentNo'] as String?,
      parentStyleupCommentNo: json['parentStyleupCommentNo'] as String?,
      memNo: json['memNo'] as String?,
      profileImage: json['profileImage'] as String?,
      nickNm: json['nickNm'] as String?,
      detail: json['detail'] as String?,
      isHeart: json['isHeart'] as bool?,
      heartCount: json['heartCount'] as int?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$ChildCommentToJson(ChildComment instance) =>
    <String, dynamic>{
      'styleupCommentNo': instance.styleupCommentNo,
      'parentStyleupCommentNo': instance.parentStyleupCommentNo,
      'memNo': instance.memNo,
      'profileImage': instance.profileImage,
      'nickNm': instance.nickNm,
      'detail': instance.detail,
      'isHeart': instance.isHeart,
      'heartCount': instance.heartCount,
      'created_at': instance.created_at,
    };
