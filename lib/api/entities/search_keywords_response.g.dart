// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_keywords_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchKeywordsResponse _$SearchKeywordsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchKeywordsResponse(
      success: json['success'] as bool,
      data: SearchKeywordsResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchKeywordsResponseToJson(
        SearchKeywordsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

SearchKeywordsResponseData _$SearchKeywordsResponseDataFromJson(
        Map<String, dynamic> json) =>
    SearchKeywordsResponseData(
      resentSearch: (json['resentSearch'] as List<dynamic>)
          .map((e) => SearchKeyword.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularSearch: (json['popularSearch'] as List<dynamic>)
          .map((e) => SearchKeyword.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchKeywordsResponseDataToJson(
        SearchKeywordsResponseData instance) =>
    <String, dynamic>{
      'resentSearch': instance.resentSearch,
      'popularSearch': instance.popularSearch,
    };

SearchKeyword _$SearchKeywordFromJson(Map<String, dynamic> json) =>
    SearchKeyword(
      keyword: json['keyword'] as String,
    );

Map<String, dynamic> _$SearchKeywordToJson(SearchKeyword instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
    };
