import 'package:showny/models/goods_item_model.dart';
import 'package:showny/models/styleup_item_model.dart';
import 'package:showny/models/user_model.dart';

class StyleupModel {
  String styleupNo;
  String memNo;
  String type;
  List<String> imgUrlList;
  String videoUrl;
  String thumbnailUrl;
  String description;
  List<dynamic> styleList; 
  List<dynamic> colorList; 
  String season;
  bool isBookmark;
  int upDownType;
  int styleupCnt;
  int heartCnt;
  int commentCnt;
  StyleupItemInfoModel itemInfo;
  UserModel userInfo;
  List<List<GoodsItemModel>> goodsDataList;
  String info1;
  String info2;

  StyleupModel({
    this.styleupNo = "",
    this.memNo = "",
    this.type = "",
    this.imgUrlList = const [],
    this.videoUrl = "",
    this.thumbnailUrl = "",
    this.description = "",
    this.styleList = const [],
    this.colorList = const [],
    this.season = "",
    this.isBookmark = false,
    this.upDownType = 0,
    this.styleupCnt = 0,
    this.heartCnt = 0,
    this.commentCnt = 0,
    StyleupItemInfoModel? itemInfo,
    UserModel? userInfo,
    this.goodsDataList = const[],
    this.info1 = "",
    this.info2 = ""
  }) : itemInfo = itemInfo ?? StyleupItemInfoModel(),
        userInfo = userInfo ?? UserModel();

  factory StyleupModel.fromJson(Map<String, dynamic> json) {
    var getGoodsDataList = (json['goodsList'] as List)
        .map((item) => GoodsItemModel.fromJson(item))
        .toList();
    List<List<GoodsItemModel>> tempGoodsDataList = [];

    var type = json['type'] as String;
    var imageUrlList = List<String>.from(json['imgUrlList'] ?? []);

    if(type == "img") {
      for(int index=0 ; index<imageUrlList.length ; index++) {
        tempGoodsDataList.add([]);
      }
    } else if(type == "video") {
      tempGoodsDataList.add([]);
    }

    for (var getGoodsData in getGoodsDataList) {
      int contentIndex = getGoodsData.contentIndex;
      tempGoodsDataList[contentIndex].add(getGoodsData);
    }

    return StyleupModel(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
      type: type,
      imgUrlList: imageUrlList,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      description: json['description'] as String,
      styleList: List<dynamic>.from(json['styleList'] ?? []),
      colorList: List<dynamic>.from(json['colorList'] ?? []),
      season: json['season'] as String,
      isBookmark: json['isBookmark'] as bool,
      upDownType: json['upDownType'] as int,
      styleupCnt: json['styleupCnt'] as int? ?? 0,
      heartCnt: json['heartCnt'] as int? ?? 0,
      commentCnt: json['commentCnt'] as int? ?? 0,
      itemInfo: StyleupItemInfoModel.fromJson(json['itemInfo'] ?? {}),
      userInfo: UserModel.fromJson(json['userInfo'] ?? {}),
      goodsDataList: tempGoodsDataList,
      info1: json['info1'] as String? ?? "",
      info2: json['info2'] as String? ?? ""
    );
  }
}