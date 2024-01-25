import 'package:showny/models/store_good_model.dart';

class GetStoreListResponseModel {
  bool? success;
  Data? data;

  GetStoreListResponseModel({this.success, this.data});

  GetStoreListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<HomeList>? homeList;
  List<BrandRankingList>? brandRankingList;
  List<StoreGoodModel>? goodsRankingList;
  List<HaertList>? haertList;

  Data(
      {this.homeList,
      this.brandRankingList,
      this.goodsRankingList,
      this.haertList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['homeList'] != null) {
      homeList = <HomeList>[];
      json['homeList'].forEach((v) {
        homeList!.add(new HomeList.fromJson(v));
      });
    }
    if (json['brandRankingList'] != null) {
      brandRankingList = <BrandRankingList>[];
      json['brandRankingList'].forEach((v) {
        brandRankingList!.add(new BrandRankingList.fromJson(v));
      });
    }

    if (json['goodsRankingList'] != null) {
      goodsRankingList = <StoreGoodModel>[];
      json['goodsRankingList'].forEach((v) {
        goodsRankingList!.add(new StoreGoodModel.fromJson(v));
      });
    }

    if (json['haertList'] != null) {
      haertList = <HaertList>[];
      json['haertList'].forEach((v) {
        haertList!.add(new HaertList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homeList != null) {
      data['homeList'] = this.homeList!.map((v) => v.toJson()).toList();
    }
    if (this.brandRankingList != null) {
      data['brandRankingList'] =
          this.brandRankingList!.map((v) => v.toJson()).toList();
    }
    if (this.goodsRankingList != null) {
      data['goodsRankingList'] =
          this.goodsRankingList!.map((v) => v.toJson()).toList();
    }
    if (this.haertList != null) {
      data['haertList'] = this.haertList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeList {
  String? goodsNo;
  String? brandNm;
  String? brandCd;
  String? goodsNm;
  String? goodsPrice;
  String? goodsImage;
  bool? isHeart;

  HomeList(
      {this.goodsNo,
      this.brandNm,
      this.brandCd,
      this.goodsNm,
      this.goodsPrice,
      this.goodsImage,
      this.isHeart});

  HomeList.fromJson(Map<String, dynamic> json) {
    goodsNo = json['goodsNo'];
    brandNm = json['brandNm'];
    brandCd = json['brandCd'];
    goodsNm = json['goodsNm'];
    goodsPrice = json['goodsPrice'];
    goodsImage = json['goodsImage'];
    isHeart = json['isHeart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsNo'] = this.goodsNo;
    data['brandNm'] = this.brandNm;
    data['brandCd'] = this.brandCd;
    data['goodsNm'] = this.goodsNm;
    data['goodsPrice'] = this.goodsPrice;
    data['goodsImage'] = this.goodsImage;
    data['isHeart'] = this.isHeart;
    return data;
  }
}

class BrandRankingList {
  String? rank;
  String? brandCd;
  String? brandNm;
  String? brandImage;
  String? upDown;

  BrandRankingList(
      {this.rank, this.brandCd, this.brandNm, this.brandImage, this.upDown});

  BrandRankingList.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    brandCd = json['brandCd'];
    brandNm = json['brandNm'];
    brandImage = json['brandImage'];
    upDown = json['upDown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['brandCd'] = this.brandCd;
    data['brandNm'] = this.brandNm;
    data['brandImage'] = this.brandImage;
    data['upDown'] = this.upDown;
    return data;
  }
}

class HaertList {
  String? goodsNo;
  String? brandNm;
  String? brandCd;
  String? goodsNm;
  String? goodsPrice;
  String? goodsImage;
  String? heartCount;
  String? reviewCount;

  HaertList(
      {this.goodsNo,
      this.brandNm,
      this.brandCd,
      this.goodsNm,
      this.goodsPrice,
      this.goodsImage,
      this.heartCount,
      this.reviewCount});

  HaertList.fromJson(Map<String, dynamic> json) {
    goodsNo = json['goodsNo'];
    brandNm = json['brandNm'];
    brandCd = json['brandCd'];
    goodsNm = json['goodsNm'];
    goodsPrice = json['goodsPrice'];
    goodsImage = json['goodsImage'];
    heartCount = json['heartCount'];
    reviewCount = json['reviewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsNo'] = this.goodsNo;
    data['brandNm'] = this.brandNm;
    data['brandCd'] = this.brandCd;
    data['goodsNm'] = this.goodsNm;
    data['goodsPrice'] = this.goodsPrice;
    data['goodsImage'] = this.goodsImage;
    data['heartCount'] = this.heartCount;
    data['reviewCount'] = this.reviewCount;
    return data;
  }
}
