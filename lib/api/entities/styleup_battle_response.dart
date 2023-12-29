import 'package:json_annotation/json_annotation.dart';
import 'package:showny/api/entities/style_up_response.dart';

part 'styleup_battle_response.g.dart';

@JsonSerializable()
class StyleupBattleResponse {
  final bool success;

  final StyleupBattleData data;

  StyleupBattleResponse({required this.data, required this.success});

  factory StyleupBattleResponse.fromJson(Map<String, dynamic> json) =>
      _$StyleupBattleResponseFromJson(json);
}

@JsonSerializable()
class StyleupBattleData {
  StyleupBattleData(
      {required this.styleupBattleNo,
      required this.round,
      required this.title,
      required this.battleItemList});

  final String styleupBattleNo;
  final String round;
  final String title;
  List<StyleupBattle> battleItemList = [];


  factory StyleupBattleData.fromJson(Map<String, dynamic> json) =>
      _$StyleupBattleDataFromJson(json);
}

@JsonSerializable()
class StyleupBattle {
  final bool isPoll;
  final Styleup styleup1;
  final Styleup styleup2;

  StyleupBattle({required this.styleup1, required this.styleup2,required this.isPoll});

  factory StyleupBattle.fromJson(Map<String, dynamic> json) =>
      _$StyleupBattleFromJson(json);
}

@JsonSerializable()
class Styleup {
  final String styleupNo;
  final String memNo;
  final String type;
  final List<String?> imgUrlList;
  final String videoUrl;
  final String thumbnailUrl;
  final String description;
  final List<String> styleList;
  final List<String> colorList;
  final String season;
  final ItemInfo itemInfo;
  final UserInfo userInfo;

  Styleup({
    required this.styleupNo,
    required this.memNo,
    required this.type,
    required this.imgUrlList,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.description,
    required this.styleList,
    required this.colorList,
    required this.season,
    required this.itemInfo,
    required this.userInfo,
  });

  factory Styleup.fromJson(Map<String, dynamic> json) =>
      _$StyleupFromJson(json);
}

@JsonSerializable()
class ItemInfo {
  final String goodsNo;
  final String goodsNm;
  final String goodsPrice;
  final String brandNm;
  final String goodsImgUrl;

  ItemInfo({
    required this.goodsNo,
    required this.goodsNm,
    required this.goodsPrice,
    required this.brandNm,
    required this.goodsImgUrl,
  });

  factory ItemInfo.fromJson(Map<String, dynamic> json) =>
      _$ItemInfoFromJson(json);
}
