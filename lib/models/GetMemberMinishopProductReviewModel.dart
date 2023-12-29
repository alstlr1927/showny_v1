import 'package:showny/models/get_goods_style_up_response_model.dart';

class GetMemberMinishopProductReviewModel {
  bool? success;
  List<Data>? data;

  GetMemberMinishopProductReviewModel({this.success, this.data});

  GetMemberMinishopProductReviewModel.fromJson(Map<String, dynamic> json) {
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
  String? content;
  String? grade;
  String? createdAt;
  MinishopProduct? minishopProduct;
  Reviewer? reviewer;

  Data(
      {this.id,
        this.content,
        this.grade,
        this.createdAt,
        this.minishopProduct,
        this.reviewer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    grade = json['grade'];
    createdAt = json['created_at'];
    minishopProduct = json['minishopProduct'] != null
        ? new MinishopProduct.fromJson(json['minishopProduct'])
        : null;
    reviewer = json['reviewer'] != null
        ? new Reviewer.fromJson(json['reviewer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['grade'] = this.grade;
    data['created_at'] = this.createdAt;
    if (this.minishopProduct != null) {
      data['minishopProduct'] = this.minishopProduct!.toJson();
    }
    if (this.reviewer != null) {
      data['reviewer'] = this.reviewer!.toJson();
    }
    return data;
  }
}

class MinishopProduct {
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
  UserInfo? userInfo;

  MinishopProduct(
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
        this.createdAt,
        this.userInfo});

  MinishopProduct.fromJson(Map<String, dynamic> json) {
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
    userInfo = UserInfo.fromJson(json['userInfo']);
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
    data['userInfo'] = this.userInfo!.toJson();
    return data;
  }
}

class Reviewer {
  String? memNo;
  String? memId;
  String? memNm;
  String? nickNm;
  int? gender;
  String? birthday;
  String? email;
  String? phone;
  String? profileImage;
  String? introduce;
  int? heightId;
  int? weightId;
  int? bodyShapeId;
  List<int>? styleIdList;
  List<int>? colorIdList;
  int? postCount;
  int? followerCount;
  int? followCount;
  bool? isFollow;

  Reviewer(
      {this.memNo,
        this.memId,
        this.memNm,
        this.nickNm,
        this.gender,
        this.birthday,
        this.email,
        this.phone,
        this.profileImage,
        this.introduce,
        this.heightId,
        this.weightId,
        this.bodyShapeId,
        this.styleIdList,
        this.colorIdList,
        this.postCount,
        this.followerCount,
        this.followCount,
        this.isFollow});

  Reviewer.fromJson(Map<String, dynamic> json) {
    memNo = json['memNo'];
    memId = json['memId'];
    memNm = json['memNm'];
    nickNm = json['nickNm'];
    gender = json['gender'];
    birthday = json['birthday'];
    email = json['email'];
    phone = json['phone'];
    profileImage = json['profileImage'];
    introduce = json['introduce'];
    heightId = json['heightId'];
    weightId = json['weightId'];
    bodyShapeId = json['bodyShapeId'];
    styleIdList = json['styleIdList'].cast<int>();
    colorIdList = json['colorIdList'].cast<int>();
    postCount = json['postCount'];
    followerCount = json['followerCount'];
    followCount = json['followCount'];
    isFollow = json['isFollow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memNo'] = this.memNo;
    data['memId'] = this.memId;
    data['memNm'] = this.memNm;
    data['nickNm'] = this.nickNm;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['profileImage'] = this.profileImage;
    data['introduce'] = this.introduce;
    data['heightId'] = this.heightId;
    data['weightId'] = this.weightId;
    data['bodyShapeId'] = this.bodyShapeId;
    data['styleIdList'] = this.styleIdList;
    data['colorIdList'] = this.colorIdList;
    data['postCount'] = this.postCount;
    data['followerCount'] = this.followerCount;
    data['followCount'] = this.followCount;
    data['isFollow'] = this.isFollow;
    return data;
  }
}
