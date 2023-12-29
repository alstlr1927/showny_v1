import 'package:showny/models/styleup_item_model.dart';
import 'package:showny/models/styleup_model.dart';

class StyleupBattleItemModel {
  String battleRoundNo;
  bool isPoll;
  int pollTag;
  StyleupModel styleup1;
  StyleupModel styleup2;
  int style1PollCnt;
  int style2PollCnt;
  // StyleupItemInfoModel itemInfo;

  StyleupBattleItemModel({
    this.battleRoundNo = "0",
    this.isPoll = false,
    this.pollTag = 0,
    this.style1PollCnt = 0,
    this.style2PollCnt = 0,
    StyleupModel? styleup1,
    StyleupModel? styleup2,
    StyleupItemInfoModel? itemInfo,
  }) : styleup1 = styleup1 ?? StyleupModel(),
        styleup2 = styleup2 ?? StyleupModel();
        // itemInfo = itemInfo ?? StyleupItemInfoModel();

  factory StyleupBattleItemModel.fromJson(Map<String, dynamic> json) {
    
    return StyleupBattleItemModel(
      battleRoundNo: json['battleRoundNo'] as String,
      isPoll: json['isPoll'] as bool,
      pollTag: json['pollTag'] as int,
      style1PollCnt: int.parse(json['style1PollCnt'] as String),
      style2PollCnt: int.parse(json['style2PollCnt'] as String),
      styleup1: StyleupModel.fromJson(json['styleup1'] ?? {}),
      styleup2: StyleupModel.fromJson(json['styleup2'] ?? {}),
      // itemInfo: StyleupItemInfoModel.fromJson(json['itemInfo'] ??{}),
    );
  }
}