import 'dart:io';

import 'package:showny/models/battle_model.dart';
import 'package:showny/models/styleup_model.dart';

class BattleUploadModel {
  BattleModel? battle;
  File? thumbNailFile;
  StyleupModel? styleup;

  BattleUploadModel({
    this.battle,
    this.thumbNailFile,
    this.styleup,
  });

  BattleUploadModel copyWith({
    BattleModel? battle,
    File? thumbNailFile,
    StyleupModel? styleup,
  }) =>
      BattleUploadModel(
        battle: battle ?? this.battle,
        thumbNailFile: thumbNailFile ?? this.thumbNailFile,
        styleup: styleup ?? this.styleup,
      );
}
