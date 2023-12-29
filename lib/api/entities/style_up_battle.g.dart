// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_up_battle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BattleResponse _$BattleResponseFromJson(Map<String, dynamic> json) =>
    BattleResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BattleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BattleResponseToJson(BattleResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

BattleData _$BattleDataFromJson(Map<String, dynamic> json) => BattleData(
      styleupBattleNo: json['styleupBattleNo'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      recruitmentStart: json['recruitmentStart'] as String,
      recruitmentEnd: json['recruitmentEnd'] as String,
      participationStart: json['participationStart'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$BattleDataToJson(BattleData instance) =>
    <String, dynamic>{
      'styleupBattleNo': instance.styleupBattleNo,
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'recruitmentStart': instance.recruitmentStart,
      'recruitmentEnd': instance.recruitmentEnd,
      'participationStart': instance.participationStart,
      'status': instance.status,
    };
