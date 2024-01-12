import 'package:flutter/material.dart';
import 'package:showny/models/styleup_battle_item_model.dart';

class StyleupBattleModel {
  String styleupBattleNo;
  String round;
  String title;
  List<StyleupBattleItemModel> battleItemList;

  StyleupBattleModel({
    this.styleupBattleNo = "",
    this.round = "",
    this.title = "",
    this.battleItemList = const [],
  });

  factory StyleupBattleModel.fromJson(Map<String, dynamic> json) {
    debugPrint("StyleupBattleModelStyleupBattleModel Parse");
    // debugPrint(json.toString());
    var battleItemList2 = (json['battleItemList'] as List)
        .map((item) => StyleupBattleItemModel.fromJson(item))
        .toList();
    // debugPrint(battleItemList2.toString());
    debugPrint("StyleupBattleModelStyleupBattleModel Parse2");

    return StyleupBattleModel(
      styleupBattleNo: json['styleupBattleNo'] as String,
      round: json['round'] as String,
      title: json['title'] as String,
      battleItemList: battleItemList2,
    );
  }
}
