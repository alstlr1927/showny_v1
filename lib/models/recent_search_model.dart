class RecentSearchModel {
  String keyword;

  RecentSearchModel({
    this.keyword = ""
  });

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) {
    return RecentSearchModel(
      keyword: json['keyword'] as String
    );
  }
}