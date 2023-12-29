import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/models/user_model.dart';

class MinishopProductReviewModel {
  String id = "";
  String content = "";
  String grade = "";
  String createdAt = "";
  UserModel reviewer;
  MinishopProductModel minishopProduct;

  MinishopProductReviewModel({
    this.id = "",
    this.content = "",
    this.grade = "",
    this.createdAt = "",
    UserModel? reviewer,
    MinishopProductModel? minishopProduct,
  })  : reviewer = reviewer ?? UserModel(),
        minishopProduct = minishopProduct ?? MinishopProductModel(userInfo: UserModel());

  factory MinishopProductReviewModel.fromJson(Map<String, dynamic> json) {

    return MinishopProductReviewModel(
      id: json['id'],
      content: json['content'],
      grade: json['grade'],
      createdAt: json['createdAt'],
      reviewer: UserModel.fromJson(json['reviewer'] ?? {}),
      minishopProduct: MinishopProductModel.fromJson(json['minishopProduct'] ?? {})
    );
  }
}
