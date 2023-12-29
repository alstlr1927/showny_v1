// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'styleup_ranking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

STURankResponse _$STURankResponseFromJson(Map<String, dynamic> json) =>
    STURankResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : STUData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$STURankResponseToJson(STURankResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

STUData _$STUDataFromJson(Map<String, dynamic> json) => STUData(
      styleupRankingList: (json['styleupRankingList'] as List<dynamic>)
          .map((e) => StyleupRanking.fromJson(e as Map<String, dynamic>))
          .toList(),
      battleRankingList: (json['battleRankingList'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => BattleRanking.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      battleWinnerList: (json['battleWinnerList'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => BattleWinner.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      styleupWinnerList: (json['styleupWinnerList'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => StyleupWinner.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$STUDataToJson(STUData instance) => <String, dynamic>{
      'styleupRankingList': instance.styleupRankingList,
      'battleRankingList': instance.battleRankingList,
      'battleWinnerList': instance.battleWinnerList,
      'styleupWinnerList': instance.styleupWinnerList,
    };

StyleupRanking _$StyleupRankingFromJson(Map<String, dynamic> json) =>
    StyleupRanking(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
      type: json['type'] as String,
      imgUrlList: json['imgUrlList'] as String,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      description: json['description'] as String,
      styleList: (json['styleList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      colorList: (json['colorList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      season: json['season'] as String,
      itemOuter: (json['itemOuter'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemTop: (json['itemTop'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemPants: (json['itemPants'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemShoes: (json['itemShoes'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemBag: (json['itemBag'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemAccessory: (json['itemAccessory'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      nickNm: json['nickNm'] as String?,
      isFollow: json['isFollow'] as bool,
      isBookmark: json['isBookmark'] as bool,
      upDownType: json['upDownType'] as int,
      popularity: json['popularity'] as int,
      ranking: json['ranking'] as int,
    );

Map<String, dynamic> _$StyleupRankingToJson(StyleupRanking instance) =>
    <String, dynamic>{
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
      'itemOuter': instance.itemOuter,
      'itemTop': instance.itemTop,
      'itemPants': instance.itemPants,
      'itemShoes': instance.itemShoes,
      'itemBag': instance.itemBag,
      'itemAccessory': instance.itemAccessory,
      'nickNm': instance.nickNm,
      'isFollow': instance.isFollow,
      'isBookmark': instance.isBookmark,
      'upDownType': instance.upDownType,
      'popularity': instance.popularity,
      'ranking': instance.ranking,
    };

ItemTagList _$ItemTagListFromJson(Map<String, dynamic> json) => ItemTagList(
      itemTagList: (json['itemTagList'] as List<dynamic>)
          .map((e) => ItemTagListComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemTagListToJson(ItemTagList instance) =>
    <String, dynamic>{
      'itemTagList': instance.itemTagList,
    };

ItemTagListComponent _$ItemTagListComponentFromJson(
        Map<String, dynamic> json) =>
    ItemTagListComponent(
      goodsNo: json['goodsNo'] as int,
      goodsSize: json['goodsSize'] as String,
      left: json['left'] as int,
      top: json['top'] as int,
    );

Map<String, dynamic> _$ItemTagListComponentToJson(
        ItemTagListComponent instance) =>
    <String, dynamic>{
      'goodsNo': instance.goodsNo,
      'goodsSize': instance.goodsSize,
      'left': instance.left,
      'top': instance.top,
    };

BattleRanking _$BattleRankingFromJson(Map<String, dynamic> json) =>
    BattleRanking(
      title: json['title'] as String,
      styleupNo: json['styleupNo'] as String,
      imgUrlList: json['imgUrlList'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$BattleRankingToJson(BattleRanking instance) =>
    <String, dynamic>{
      'title': instance.title,
      'styleupNo': instance.styleupNo,
      'imgUrlList': instance.imgUrlList,
      'description': instance.description,
    };

BattleWinner _$BattleWinnerFromJson(Map<String, dynamic> json) => BattleWinner(
      title: json['title'] as String,
      styleupBattleNo: json['styleupBattleNo'] as String,
      styleupNo: json['styleupNo'] as String,
      imgUrlList: json['imgUrlList'] as String,
    );

Map<String, dynamic> _$BattleWinnerToJson(BattleWinner instance) =>
    <String, dynamic>{
      'title': instance.title,
      'styleupBattleNo': instance.styleupBattleNo,
      'styleupNo': instance.styleupNo,
      'imgUrlList': instance.imgUrlList,
    };

StyleupWinner _$StyleupWinnerFromJson(Map<String, dynamic> json) =>
    StyleupWinner(
      styleupNo: json['styleupNo'] as String,
      imgUrlList: json['imgUrlList'] as String,
      upCnt: json['upCnt'] as String,
    );

Map<String, dynamic> _$StyleupWinnerToJson(StyleupWinner instance) =>
    <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'imgUrlList': instance.imgUrlList,
      'upCnt': instance.upCnt,
    };
