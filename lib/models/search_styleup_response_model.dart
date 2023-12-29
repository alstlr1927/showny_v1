import 'package:showny/models/styleup_model.dart';

class SearchStyleupResponseModel {
  int totalCount;
  List<StyleupModel> styleupList;

  SearchStyleupResponseModel({
    this.totalCount = 0,
    this.styleupList = const []
  });

  factory SearchStyleupResponseModel.fromJson(Map<String, dynamic> json) {
    var styleupModelList = (json['styleupData'] as List)
        .map((item) => StyleupModel.fromJson(item))
        .toList();
        
    return SearchStyleupResponseModel(
      totalCount: json['totalCount'] as int,
      styleupList: styleupModelList
    );
  }
}