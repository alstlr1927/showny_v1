import 'package:showny/models/store_good_model.dart';

class SearchStoreGoodModelResponse {
  bool? success;
  Data? data;

  SearchStoreGoodModelResponse({this.success, this.data});

  SearchStoreGoodModelResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<StoreGoodModel>? goodsData;
  int? totalCount;

  Data({this.goodsData, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['goodsData'] != null) {
      goodsData = <StoreGoodModel>[];
      json['goodsData'].forEach((v) {
        goodsData!.add(StoreGoodModel.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (goodsData != null) {
      data['goodsData'] = goodsData!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }
}
