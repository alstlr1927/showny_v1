import 'package:showny/models/recent_search_model.dart';

class RecentSearchListModel {
  List<RecentSearchModel> recentSearch;
  List<RecentSearchModel> popularSearch;

  RecentSearchListModel({
    this.recentSearch = const [],
    this.popularSearch = const []
  });

  factory RecentSearchListModel.fromJson(Map<String, dynamic> json) {
    var recentSearchList = (json['recentSearch'] as List)
        .map((item) => RecentSearchModel.fromJson(item))
        .toList();
    var popularSearchList = (json['popularSearch'] as List)
        .map((item) => RecentSearchModel.fromJson(item))
        .toList();
        
    return RecentSearchListModel(
      recentSearch: recentSearchList,
      popularSearch: popularSearchList
    );
  }
}