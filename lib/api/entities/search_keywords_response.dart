import 'package:json_annotation/json_annotation.dart';

part 'search_keywords_response.g.dart';

@JsonSerializable()
class SearchKeywordsResponse {
  final bool success;
  final SearchKeywordsResponseData data;

  SearchKeywordsResponse({
    required this.success,
    required this.data,
  });

  factory SearchKeywordsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordsResponseToJson(this);
}

@JsonSerializable()
class SearchKeywordsResponseData {
  final List<SearchKeyword> resentSearch;
  final List<SearchKeyword> popularSearch;

  SearchKeywordsResponseData({
    required this.resentSearch,
    required this.popularSearch,
  });

  factory SearchKeywordsResponseData.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordsResponseDataToJson(this);
}

@JsonSerializable()
class SearchKeyword {
  final String keyword;

  SearchKeyword({
    required this.keyword,
  });

  factory SearchKeyword.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordToJson(this);
}
