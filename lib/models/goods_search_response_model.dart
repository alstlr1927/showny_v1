import 'package:showny/models/store_good_model.dart';

class GoodsSearchResponseModel {
  int totalCount;
  List<StoreGoodModel> goodsList;

  GoodsSearchResponseModel({
    this.totalCount = 0,
    this.goodsList = const []
  });

  factory GoodsSearchResponseModel.fromJson(Map<String, dynamic> json) {
    var goodsDataList = (json['goodsData'] as List)
        .map((item) => StoreGoodModel.fromJson(item))
        .toList();
        
    return GoodsSearchResponseModel(
      totalCount: json['totalCount'] as int,
      goodsList: goodsDataList
    );
  }
}