class GoodsData {
  String? goodsNo;
  String? goodsNm;
  int? goodsPrice;
  int? goodsDiscount;
  List<String>? goodsImageUrlList;
  String? brandNm;
  String? brandCd;
  String? brandImgUrl;
  int? heartCount;
  int? reviewCount;
  String? goodsDescription;
  List<List<Option>>? options;
  double left = 0;
  double top = 0;

  GoodsData({
    this.goodsNo,
    this.goodsNm,
    this.goodsPrice,
    this.goodsDiscount,
    this.goodsImageUrlList,
    this.brandNm,
    this.brandCd,
    this.brandImgUrl,
    this.heartCount,
    this.reviewCount,
    this.goodsDescription,
    this.options,
  });

  GoodsData.fromJson(Map<String, dynamic> json) {
    goodsNo = json['goodsNo'];
    goodsNm = json['goodsNm'];
    goodsPrice = json['goodsPrice'];
    goodsDiscount = json['goodsDiscount'];
    goodsImageUrlList = json['goodsImageUrlList'].cast<String>();
    brandNm = json['brandNm'];
    brandCd = json['brandCd'];
    brandImgUrl = json['brandImgUrl'];
    heartCount = json['heartCount'];
    reviewCount = json['reviewCount'];
    goodsDescription = json['goodsDescription'];

    if (json['options'] != null) {
      options = <List<Option>>[];
      json['options'].forEach((v) {
        options!.add(List<Option>.from(v.map((x) => Option.fromJson(x))));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goodsNo'] = this.goodsNo;
    data['goodsNm'] = this.goodsNm;
    data['goodsPrice'] = this.goodsPrice;
    data['goodsDiscount'] = this.goodsDiscount;
    data['goodsImageUrlList'] = this.goodsImageUrlList;
    data['brandNm'] = this.brandNm;
    data['brandCd'] = this.brandCd;
    data['brandImgUrl'] = this.brandImgUrl;
    data['heartCount'] = this.heartCount;
    data['reviewCount'] = this.reviewCount;
    data['goodsDescription'] = this.goodsDescription;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.map((x) => x.toJson()).toList()).toList();
    }
    return data;
  }
}

class Option {
  String? key;
  String? value;

  Option({this.key, this.value});

  Option.fromJson(Map<String, dynamic> json) {
    key = json.keys.first;
    value = json.values.first.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[key!] = this.value;
    return data;
  }
}
