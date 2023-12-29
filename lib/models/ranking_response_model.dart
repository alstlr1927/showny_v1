import 'package:showny/models/battle_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/models/styleup_ranking_model.dart';

class RankingResponseModel {
  List<StyleupModel> styleupRankingList;
  List<StyleupModel> battleRankingList;
  List<StyleupModel> battleWinnerList;
  List<StyleupModel> styleupWinnerList;

  RankingResponseModel({
    this.styleupRankingList = const [],
    this.battleRankingList = const [],
    this.battleWinnerList = const [],
    this.styleupWinnerList = const []
  });

  factory RankingResponseModel.fromJson(Map<String, dynamic> json) {
    var styleupRankingList = (json['styleupRankingList'] as List)
        .map((item) => StyleupModel.fromJson(item))
        .toList();
    var battleRankingList = (json['battleRankingList'] as List)
        .map((item) => StyleupModel.fromJson(item))
        .toList();
    var battleWinnerList = (json['battleWinnerList'] as List)
        .map((item) => StyleupModel.fromJson(item))
        .toList();
    var styleupWinnerList = (json['styleupWinnerList'] as List)
        .map((item) => StyleupModel.fromJson(item))
        .toList();
        
    return RankingResponseModel(
      styleupRankingList: styleupRankingList,
      battleRankingList: battleRankingList,
      battleWinnerList: battleWinnerList,
      styleupWinnerList: styleupWinnerList
    );
  }
}