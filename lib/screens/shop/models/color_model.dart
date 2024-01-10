// To parse this JSON data, do
//
//     final colorResponseModel = colorResponseModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

ColorResponseModel colorResponseModelFromJson(String str) =>
    ColorResponseModel.fromJson(json.decode(str));

String colorResponseModelToJson(ColorResponseModel data) =>
    json.encode(data.toJson());

class ColorResponseModel {
  int id;
  Color colorHex;
  String colorName;

  ColorResponseModel({
    required this.id,
    required this.colorHex,
    required this.colorName,
  });

  factory ColorResponseModel.fromJson(Map<String, dynamic> json) =>
      ColorResponseModel(
        id: json["id"],
        colorHex: json["colorHex"],
        colorName: json["colorName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "colorHex": colorHex,
        "colorName": colorName,
      };
}
