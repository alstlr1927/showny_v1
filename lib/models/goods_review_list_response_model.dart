import 'package:showny/models/goods_review_model.dart';

class GoodsReviewListResponseModel {
  int reviewCount;
  List<GoodsReviewModel> reviewList;

  GoodsReviewListResponseModel(
      {this.reviewCount = 0, this.reviewList = const []});

  factory GoodsReviewListResponseModel.fromJson(Map<String, dynamic> json) {
    var reviewListModel = (json['reviewList'] as List)
        .map((item) => GoodsReviewModel.fromJson(item))
        .toList();

    return GoodsReviewListResponseModel(
        reviewCount: json['reviewCount'] as int, reviewList: reviewListModel);
  }
}
