// To parse this JSON data, do
//
//     final exchangeReturnResponseModel = exchangeReturnResponseModelFromJson(jsonString);

import 'dart:convert';

ExchangeReturnResponseModel exchangeReturnResponseModelFromJson(String str) =>
    ExchangeReturnResponseModel.fromJson(json.decode(str));

String exchangeReturnResponseModelToJson(ExchangeReturnResponseModel data) =>
    json.encode(data.toJson());

class ExchangeReturnResponseModel {
  int? id;
  int? productAmount;
  int? deliveryFee;
  int? amountOfPayment;
  String? productName;
  String? productInfo;
  String? productSize;
  String? productQuantity;
  String? image;

  ExchangeReturnResponseModel({
    this.id,
    this.productAmount,
    this.deliveryFee,
    this.amountOfPayment,
    this.productName,
    this.productInfo,
    this.productSize,
    this.productQuantity,
    this.image,
  });

  factory ExchangeReturnResponseModel.fromJson(Map<String, dynamic> json) =>
      ExchangeReturnResponseModel(
        id: json["id"],
        productAmount: json["productAmount"],
        deliveryFee: json["deliveryFee"],
        amountOfPayment: json["amountOfPayment"],
        productName: json["productName"],
        productInfo: json["productInfo"],
        productSize: json["productSize"],
        productQuantity: json["productQuantity"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productAmount": productAmount,
        "deliveryFee": deliveryFee,
        "amountOfPayment": amountOfPayment,
        "productName": productName,
        "productInfo": productInfo,
        "productSize": productSize,
        "productQuantity": productQuantity,
        "image": image,
      };
}
