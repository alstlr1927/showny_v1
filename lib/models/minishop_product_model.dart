import 'package:showny/models/user_model.dart';

class MinishopProductModel {
  String id = "";
  String memNo = "";
  String name = "";
  int categoryId = 0;
  bool isHeart = false;
  int price = 0;
  int deliveryPrice = 0;
  String viewSize = "";
  bool isNew = false;
  String description = "";
  String brand = "";
  String brandImageUrl = "";
  String actualSize = "";
  String colorIdList = "";
  List<String> productImageUrlList = [];
  List<String> wearImageUrlList = [];
  int status = 0;
  String createdAt = "";
  UserModel? userInfo;

  MinishopProductModel(
      {this.id = "",
        this.memNo = "",
        this.name = "",
        this.categoryId = 0,
        this.isHeart = false,
        this.price = 0,
        this.deliveryPrice = 0,
        this.viewSize = "",
        this.isNew = false,
        this.description = "",
        this.brand = "",
        this.brandImageUrl = "",
        this.actualSize = "",
        this.colorIdList = "",
        this.productImageUrlList = const [],
        this.wearImageUrlList = const [],
        this.status = 0,
        this.createdAt = "",
        this.userInfo,});

  factory MinishopProductModel.fromJson(Map<String, dynamic> json) {
    return MinishopProductModel(
      id : json['id'],
      memNo : json['memNo'],
      name : json['name'],
      categoryId : json['categoryId'],
      isHeart : json['isHeart'],
      price : json['price'],
      deliveryPrice : json['deliveryPrice'],
      viewSize : json['viewSize'],
      isNew : json['isNew'],
      description : json['description'],
      brand : json['brand'],
      brandImageUrl : json['brandImageUrl'],
      actualSize : json['actualSize'],
      colorIdList : json['colorIdList'],
      productImageUrlList : json['productImageUrlList'].cast<String>(),
      wearImageUrlList : json['wearImageUrlList'].cast<String>(),
      status : json['status'],
      createdAt : json['created_at'],
      userInfo : UserModel.fromJson(json['userInfo'] as Map<String, dynamic>)
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['memNo'] = memNo;
    data['name'] = name;
    data['categoryId'] = categoryId;
    data['isHeart'] = isHeart;
    data['price'] = price;
    data['deliveryPrice'] = deliveryPrice;
    data['viewSize'] = viewSize;
    data['isNew'] = isNew;
    data['description'] = description;
    data['brand'] = brand;
    data['brandImageUrl'] = brandImageUrl;
    data['actualSize'] = actualSize;
    data['colorIdList'] = colorIdList;
    data['productImageUrlList'] = productImageUrlList;
    data['wearImageUrlList'] = wearImageUrlList;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}