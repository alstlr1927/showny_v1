import 'package:showny/models/user_model.dart';

class GoodsReviewModel {
  String sno = "";
  String memNo = "";
  String subject = "";
  String contents = "";
  String goodsPt = "";
  String regDt = "";
  UserModel userInfo;

  GoodsReviewModel({
    this.sno = "",
    this.memNo = "",
    this.subject = "",
    this.contents = "",
    this.goodsPt = "",
    this.regDt = "",
    UserModel? userInfo,
  }) : userInfo = userInfo ?? UserModel();

  factory GoodsReviewModel.fromJson(Map<String, dynamic> json) {
    return GoodsReviewModel(
      sno: json['sno'] as String? ?? "",
      memNo: json['memNo'] as String? ?? "",
      subject: json['subject'] as String? ?? "",
      contents: json['contents'] as String? ?? "",
      goodsPt: json['goodsPt'] as String? ?? "",
      regDt: json['regDt'] as String? ?? "",
      userInfo: UserModel.fromJson(json['userInfo'] ?? {}),
    );
  }
}
