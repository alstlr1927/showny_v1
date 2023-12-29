import 'package:json_annotation/json_annotation.dart';

part 'style_up_battle.g.dart';

@JsonSerializable()
class BattleResponse {
  BattleResponse({
    required this.success,
    this.data,
  });

  bool success;
  List<BattleData>? data;

  factory BattleResponse.fromJson(Map<String, dynamic> json) =>
      _$BattleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BattleResponseToJson(this);
}

@JsonSerializable()
class BattleData {
  BattleData({
    required this.styleupBattleNo,
    required this.title,
    required this.thumbnailUrl,
    required this.recruitmentStart,
    required this.recruitmentEnd,
    required this.participationStart,
    required this.status,
  });

  String styleupBattleNo;
  String title;
  String thumbnailUrl;
  String recruitmentStart;
  String recruitmentEnd;
  String participationStart;
  String status;

  factory BattleData.fromJson(Map<String, dynamic> json) =>
      _$BattleDataFromJson(json);

  Map<String, dynamic> toJson() => _$BattleDataToJson(this);
}
