class FetchGetMemberMinishopProductModel {
  bool? success;
  List<Data>? data;

  FetchGetMemberMinishopProductModel({this.success, this.data});

  FetchGetMemberMinishopProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? memNo;
  String? name;
  int? categoryId;
  bool? isHeart;
  int? price;
  int? deliveryPrice;
  String? viewSize;
  bool? isNew;
  String? description;
  String? brand;
  String? brandImageUrl;
  String? actualSize;
  String? colorIdList;
  List<String>? productImageUrlList;
  List<String>? wearImageUrlList;
  int? status;
  String? createdAt;

  Data(
      {this.id,
        this.memNo,
        this.name,
        this.categoryId,
        this.isHeart,
        this.price,
        this.deliveryPrice,
        this.viewSize,
        this.isNew,
        this.description,
        this.brand,
        this.brandImageUrl,
        this.actualSize,
        this.colorIdList,
        this.productImageUrlList,
        this.wearImageUrlList,
        this.status,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memNo = json['memNo'];
    name = json['name'];
    categoryId = json['categoryId'];
    isHeart = json['isHeart'];
    price = json['price'];
    deliveryPrice = json['deliveryPrice'];
    viewSize = json['viewSize'];
    isNew = json['isNew'];
    description = json['description'];
    brand = json['brand'];
    brandImageUrl = json['brandImageUrl'];
    actualSize = json['actualSize'];
    colorIdList = json['colorIdList'];
    productImageUrlList = json['productImageUrlList'].cast<String>();
    wearImageUrlList = json['wearImageUrlList'].cast<String>();
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memNo'] = this.memNo;
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    data['isHeart'] = this.isHeart;
    data['price'] = this.price;
    data['deliveryPrice'] = this.deliveryPrice;
    data['viewSize'] = this.viewSize;
    data['isNew'] = this.isNew;
    data['description'] = this.description;
    data['brand'] = this.brand;
    data['brandImageUrl'] = this.brandImageUrl;
    data['actualSize'] = this.actualSize;
    data['colorIdList'] = this.colorIdList;
    data['productImageUrlList'] = this.productImageUrlList;
    data['wearImageUrlList'] = this.wearImageUrlList;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
