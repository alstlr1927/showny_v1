// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'styleup_battle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleupBattleResponse _$StyleupBattleResponseFromJson(
        Map<String, dynamic> json) =>
    StyleupBattleResponse(
      data: StyleupBattleData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$StyleupBattleResponseToJson(
        StyleupBattleResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

StyleupBattleData _$StyleupBattleDataFromJson(Map<String, dynamic> json) =>
    StyleupBattleData(
      styleupBattleNo: json['styleupBattleNo'] as String,
      round: json['round'] as String,
      title: json['title'] as String,
      battleItemList: (json['battleItemList'] as List<dynamic>)
          .map((e) => StyleupBattle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StyleupBattleDataToJson(StyleupBattleData instance) =>
    <String, dynamic>{
      'styleupBattleNo': instance.styleupBattleNo,
      'round': instance.round,
      'title': instance.title,
      'battleItemList': instance.battleItemList,
    };

StyleupBattle _$StyleupBattleFromJson(Map<String, dynamic> json) =>
    StyleupBattle(
      styleup1: Styleup.fromJson(json['styleup1'] as Map<String, dynamic>),
      styleup2: Styleup.fromJson(json['styleup2'] as Map<String, dynamic>),
      isPoll: json['isPoll'] as bool,
    );

Map<String, dynamic> _$StyleupBattleToJson(StyleupBattle instance) =>
    <String, dynamic>{
      'isPoll': instance.isPoll,
      'styleup1': instance.styleup1,
      'styleup2': instance.styleup2,
    };

Styleup _$StyleupFromJson(Map<String, dynamic> json) => Styleup(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
      type: json['type'] as String,
      imgUrlList: (json['imgUrlList'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      description: json['description'] as String,
      styleList:
          (json['styleList'] as List<dynamic>).map((e) => e as String).toList(),
      colorList:
          (json['colorList'] as List<dynamic>).map((e) => e as String).toList(),
      season: json['season'] as String,
      itemInfo: ItemInfo.fromJson(json['itemInfo'] as Map<String, dynamic>),
      userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StyleupToJson(Styleup instance) => <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'memNo': instance.memNo,
      'type': instance.type,
      'imgUrlList': instance.imgUrlList,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'styleList': instance.styleList,
      'colorList': instance.colorList,
      'season': instance.season,
      'itemInfo': instance.itemInfo,
      'userInfo': instance.userInfo,
    };

ItemInfo _$ItemInfoFromJson(Map<String, dynamic> json) => ItemInfo(
      goodsNo: json['goodsNo'] as String,
      goodsNm: json['goodsNm'] as String,
      goodsPrice: json['goodsPrice'] as String,
      brandNm: json['brandNm'] as String,
      goodsImgUrl: json['goodsImgUrl'] as String,
    );

Map<String, dynamic> _$ItemInfoToJson(ItemInfo instance) => <String, dynamic>{
      'goodsNo': instance.goodsNo,
      'goodsNm': instance.goodsNm,
      'goodsPrice': instance.goodsPrice,
      'brandNm': instance.brandNm,
      'goodsImgUrl': instance.goodsImgUrl,
    };
