import 'package:showny/models/styleup_item_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/models/user_model.dart';

class StyleupRankingModel extends StyleupModel {
  int ranking;
  String upCnt;

  StyleupRankingModel({
    String styleupNo = "",
    String memNo = "",
    String type = "",
    List<String> imgUrlList = const [],
    String videoUrl = "",
    String thumbnailUrl = "",
    String description = "",
    List<dynamic> styleList = const [],
    List<dynamic> colorList = const [],
    String season = "",
    bool isBookmark = false,
    int upDownType = 0,
    this.ranking = 0,
    this.upCnt = "",
    required StyleupItemInfoModel itemInfo,
    required UserModel userInfo,
  }) : super(
          styleupNo: styleupNo,
          memNo: memNo,
          type: type,
          imgUrlList: imgUrlList,
          videoUrl: videoUrl,
          thumbnailUrl: thumbnailUrl,
          description: description,
          styleList: styleList,
          colorList: colorList,
          season: season,
          isBookmark: isBookmark,
          upDownType: upDownType,
          itemInfo: itemInfo,
          userInfo: userInfo,
        );

  factory StyleupRankingModel.fromJson(Map<String, dynamic> json) {
    return StyleupRankingModel(
      ranking: json['ranking'] as int, 
      upCnt: json['upCnt'] as String, 
      itemInfo: StyleupItemInfoModel.fromJson(json['itemInfo'] ?? {}),
      userInfo: UserModel.fromJson(json['userInfo'] ?? {}),
    );
  }
}