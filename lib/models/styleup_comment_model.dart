import 'package:showny/models/user_model.dart';

class StyleupCommentModel {
  String styleupCommentNo;
  String memNo;
  String detail;
  bool isHeart;
  int heartCount;
  String createdAt;
  List<StyleupCommentModel> childCommentList;
  UserModel userInfo;

  StyleupCommentModel({
    this.styleupCommentNo = "",
    this.memNo = "",
    this.detail = "",
    this.isHeart = false,
    this.heartCount = 0,
    this.createdAt = "",
    this.childCommentList = const [],
    required this.userInfo,
  });

  factory StyleupCommentModel.fromJson(Map<String, dynamic> json) {
    return StyleupCommentModel(
      styleupCommentNo: json['styleupCommentNo'] as String,
      memNo: json['memNo'] as String,
      detail: json['detail'] as String,
      isHeart: json['isHeart'] as bool,
      heartCount: json['heartCount'] as int,
      createdAt: json['created_at'] as String,
      childCommentList: (json['childCommenList'] as List<dynamic>?)
              ?.map((e) =>
                  StyleupCommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      userInfo: UserModel.fromJson(json['userInfo'] as Map<String, dynamic>),
    );
  }
}
