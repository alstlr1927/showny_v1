import 'package:json_annotation/json_annotation.dart';

part 'styleup_ranking_response.g.dart';

@JsonSerializable()
class STURankResponse {
  STURankResponse({
    required this.success,
    this.data,
  });

  bool success;
  STUData? data;

  factory STURankResponse.fromJson(Map<String, dynamic> json) =>
      _$STURankResponseFromJson(json);

  Map<String, dynamic> toJson() => _$STURankResponseToJson(this);
}

@JsonSerializable()
class STUData {
  STUData({
    required this.styleupRankingList,
    required this.battleRankingList,
    required this.battleWinnerList,
    required this.styleupWinnerList,
  });

  List<StyleupRanking> styleupRankingList;
  List<List<BattleRanking>> battleRankingList;
  List<List<BattleWinner>> battleWinnerList;
  List<List<StyleupWinner>> styleupWinnerList;

  factory STUData.fromJson(Map<String, dynamic> json) =>
      _$STUDataFromJson(json);

  Map<String, dynamic> toJson() => _$STUDataToJson(this);
}

@JsonSerializable()
class StyleupRanking {
  StyleupRanking({
    required this.styleupNo,
    required this.memNo,
    required this.type,
    required this.imgUrlList,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.description,
    this.styleList,
    this.colorList,
    required this.season,
    this.itemOuter,
    this.itemTop,
    this.itemPants,
    this.itemShoes,
    this.itemBag,
    this.itemAccessory,
    this.nickNm,
    required this.isFollow,
    required this.isBookmark,
    required this.upDownType,
    required this.popularity,
    required this.ranking,
  });

  String styleupNo;
  String memNo;
  String type;
  String imgUrlList;
  String videoUrl;
  String thumbnailUrl;
  String description;
  List<String>? styleList;
  List<String>? colorList;
  String season;
  List<ItemTagList>? itemOuter;
  List<ItemTagList>? itemTop;
  List<ItemTagList>? itemPants;
  List<ItemTagList>? itemShoes;
  List<ItemTagList>? itemBag;
  List<ItemTagList>? itemAccessory;
  String? nickNm;
  bool isFollow;
  bool isBookmark;
  int upDownType;
  int popularity;
  int ranking;

  factory StyleupRanking.fromJson(Map<String, dynamic> json) =>
      _$StyleupRankingFromJson(json);

  Map<String, dynamic> toJson() => _$StyleupRankingToJson(this);
}

@JsonSerializable()
class ItemTagList {
  ItemTagList({
    required this.itemTagList,
  });

  List<ItemTagListComponent> itemTagList;

  factory ItemTagList.fromJson(Map<String, dynamic> json) =>
      _$ItemTagListFromJson(json);

  Map<String, dynamic> toJson() => _$ItemTagListToJson(this);
}

@JsonSerializable()
class ItemTagListComponent {
  ItemTagListComponent({
    required this.goodsNo,
    required this.goodsSize,
    required this.left,
    required this.top,
  });

  int goodsNo;
  String goodsSize;
  int left;
  int top;

  factory ItemTagListComponent.fromJson(Map<String, dynamic> json) =>
      _$ItemTagListComponentFromJson(json);

  Map<String, dynamic> toJson() => _$ItemTagListComponentToJson(this);
}

@JsonSerializable()
class BattleRanking {
  BattleRanking({
    required this.title,
    required this.styleupNo,
    required this.imgUrlList,
    required this.description,
  });

  String title;
  String styleupNo;
  String imgUrlList;
  String description;

  factory BattleRanking.fromJson(Map<String, dynamic> json) =>
      _$BattleRankingFromJson(json);

  Map<String, dynamic> toJson() => _$BattleRankingToJson(this);
}

@JsonSerializable()
class BattleWinner {
  BattleWinner({
    required this.title,
    required this.styleupBattleNo,
    required this.styleupNo,
    required this.imgUrlList,
  });

  String title;
  String styleupBattleNo;
  String styleupNo;
  String imgUrlList;

  factory BattleWinner.fromJson(Map<String, dynamic> json) =>
      _$BattleWinnerFromJson(json);

  Map<String, dynamic> toJson() => _$BattleWinnerToJson(this);
}

@JsonSerializable()
class StyleupWinner {
  StyleupWinner({
    required this.styleupNo,
    required this.imgUrlList,
    required this.upCnt,
  });

  String styleupNo;
  String imgUrlList;
  String upCnt;

  factory StyleupWinner.fromJson(Map<String, dynamic> json) =>
      _$StyleupWinnerFromJson(json);

  Map<String, dynamic> toJson() => _$StyleupWinnerToJson(this);
}
