// To parse this JSON data, do
//
//     final styleResponseModel = styleResponseModelFromJson(jsonString);

import 'dart:convert';

StyleResponseModel styleResponseModelFromJson(String str) =>
    StyleResponseModel.fromJson(json.decode(str));

String styleResponseModelToJson(StyleResponseModel data) =>
    json.encode(data.toJson());

class StyleResponseModel {
  int id;
  String name;

  StyleResponseModel({
    required this.id,
    required this.name,
  });

  factory StyleResponseModel.fromJson(Map<String, dynamic> json) =>
      StyleResponseModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
