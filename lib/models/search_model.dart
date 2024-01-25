// To parse this JSON data, do
//
//     final searchResponseModel = searchResponseModelFromJson(jsonString);

import 'dart:convert';

SearchResponseModel searchResponseModelFromJson(String str) =>
    SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) =>
    json.encode(data.toJson());

class SearchResponseModel {
  bool success;
  Data data;

  SearchResponseModel({
    required this.success,
    required this.data,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchResponseModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  List<Search> resentSearch;
  List<Search> popularSearch;

  Data({
    required this.resentSearch,
    required this.popularSearch,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        resentSearch: List<Search>.from(
            json["resentSearch"].map((x) => Search.fromJson(x))),
        popularSearch: List<Search>.from(
            json["popularSearch"].map((x) => Search.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resentSearch": List<dynamic>.from(resentSearch.map((x) => x.toJson())),
        "popularSearch":
            List<dynamic>.from(popularSearch.map((x) => x.toJson())),
      };
}

class Search {
  String keyword;

  Search({
    required this.keyword,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        keyword: json["keyword"],
      );

  Map<String, dynamic> toJson() => {
        "keyword": keyword,
      };
}
