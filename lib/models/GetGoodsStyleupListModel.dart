import 'package:showny/models/styleup_model.dart';

class GetGoodsStyleupListModel {
  int styleupCount;
  List<StyleupModel> styleupDataList;

  GetGoodsStyleupListModel({
    this.styleupCount = 0,
    this.styleupDataList = const []
  });

  factory GetGoodsStyleupListModel.fromJson(Map<String, dynamic> json) {
    var styleupDataList = (json['styleupData'] as List)
        .map((item) => StyleupModel.fromJson(item))
        .toList();
        
    return GetGoodsStyleupListModel(
      styleupCount: int.parse(json['styleupCount'] as String),
      styleupDataList: styleupDataList
    );
  }
}