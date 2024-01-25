class MinishopSearchModel {
  MinishopSearchModel({
    this.success,
    this.data,
  });
  bool? success;
  Data? data;

  MinishopSearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.recentSearch,
    this.popularSearch,
  });
  List<RecentSearch>? recentSearch;
  List<PopularSearch>? popularSearch;

  Data.fromJson(Map<String, dynamic> json) {
    recentSearch = List.from(json['recentSearch'])
        .map((e) => RecentSearch.fromJson(e))
        .toList();
    popularSearch = List.from(json['popularSearch'])
        .map((e) => PopularSearch.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['recentSearch'] = recentSearch!.map((e) => e.toJson()).toList();
    _data['popularSearch'] = popularSearch!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class RecentSearch {
  RecentSearch({
    this.keyword,
  });
  String? keyword;

  RecentSearch.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['keyword'] = keyword;
    return _data;
  }
}

class PopularSearch {
  PopularSearch({
    this.keyword,
  });
  String? keyword;

  PopularSearch.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['keyword'] = keyword;
    return _data;
  }
}
