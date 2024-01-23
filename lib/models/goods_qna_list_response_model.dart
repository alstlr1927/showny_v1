import 'package:showny/models/goods_qna_model.dart';

class GoodsQnaListResponseModel {
  int qaCount;
  List<GoodsQnaModel> qaList;

  GoodsQnaListResponseModel({this.qaCount = 0, this.qaList = const []});

  factory GoodsQnaListResponseModel.fromJson(Map<String, dynamic> json) {
    var reviewListModel = (json['qaList'] as List)
        .map((item) => GoodsQnaModel.fromJson(item))
        .toList();

    return GoodsQnaListResponseModel(
        qaCount: json['qaCount'] as int, qaList: reviewListModel);
  }
}
