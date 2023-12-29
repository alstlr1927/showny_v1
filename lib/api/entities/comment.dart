// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class CommentResponse {
  CommentResponse({
    required this.success,
    this.data,
    this.error,
  });

  bool success;
  List<CommentData>? data;
  String? error;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}

@JsonSerializable()
class CommentData {
  CommentData({
    required this.styleupCommentNo,
    required this.memNo,
    required this.profileImage,
    required this.nickNm,
    required this.detail,
    required this.isHeart,
    required this.heartCount,
    required this.created_at,
    required this.childCommenList,
  });

  late final String? styleupCommentNo;
  late final String? memNo;
  late final String? profileImage;
  late final String? nickNm;
  late final String? detail;
  late final bool? isHeart;
  late final int? heartCount;
  late final String? created_at;
  late final List<ChildComment>? childCommenList;

  factory CommentData.fromJson(Map<String, dynamic> json) =>
      _$CommentDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDataToJson(this);
}

@JsonSerializable()
class ChildComment {
  ChildComment({
    required this.styleupCommentNo,
    required this.parentStyleupCommentNo,
    required this.memNo,
    required this.profileImage,
    required this.nickNm,
    required this.detail,
    required this.isHeart,
    required this.heartCount,
    required this.created_at,
  });

  late final String? styleupCommentNo;
  late final String? parentStyleupCommentNo;
  late final String? memNo;
  late final String? profileImage;
  late final String? nickNm;
  late final String? detail;
  late final bool? isHeart;
  late final int? heartCount;
  late final String? created_at;

  factory ChildComment.fromJson(Map<String, dynamic> json) =>
      _$ChildCommentFromJson(json);

  Map<String, dynamic> toJson() => _$ChildCommentToJson(this);
}
