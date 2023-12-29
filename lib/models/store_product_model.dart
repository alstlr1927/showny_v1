class StoreProductModel {
  String goodsNo;
  String goodsNm;
  int goodsPrice;
  int goodsDiscount;
  List<String> goodsImageUrlList;
  String brandNm;
  String brandCd;
  String brandImgUrl;
  int heartCount;
  int reviewCount;
  double grade;
  String goodsDescription;
  List<String> options;
  String productGuideInfo;
  List<Map<String, String>> productNoticeInfo;
  List<Map<String, String>> sellerInfo;

  StoreProductModel({
    this.goodsNo = "",
    this.goodsNm = "",
    this.goodsPrice = 0,
    this.goodsDiscount = 0,
    this.goodsImageUrlList = const [],
    this.brandNm = "",
    this.brandCd = "",
    this.brandImgUrl = "",
    this.heartCount = 0,
    this.reviewCount = 0,
    this.grade = 0.0,
    this.goodsDescription = "",
    this.options = const [],
    this.productGuideInfo = "",
    this.productNoticeInfo = const [],
    this.sellerInfo = const [],
  });

  factory StoreProductModel.fromJson(Map<String, dynamic> json) {
    return StoreProductModel(
      goodsNo: json['goodsNo'] as String,
      goodsNm: json['goodsNm'] as String,
      goodsPrice: json['goodsPrice'] as int,
      goodsDiscount: json['goodsDiscount'] as int,
      goodsImageUrlList: List<String>.from(json['goodsImageUrlList'] ?? []),
      brandNm: json['brandNm'] as String,
      brandCd: json['brandCd'] as String,
      brandImgUrl: json['brandImgUrl'] as String,
      heartCount: json['heartCount'] as int,
      reviewCount: json['reviewCount'] as int,
      grade: (json['grade'] as num).toDouble(),
      goodsDescription: json['goodsDescription'] as String,
      options: List<String>.from(json['options'] ?? []),
      productGuideInfo: json['productGuideInfo'] as String,
      productNoticeInfo: (json['productNoticeInfo'] as List<dynamic>?)
              ?.map((notice) => {
                    'key': notice['key'] as String,
                    'value': notice['value'] as String
                  })
              .toList() ??
          [],
      sellerInfo: (json['sellerInfo'] as List<dynamic>?)
              ?.map((seller) => {
                    'key': seller['key'] as String,
                    'value': seller['value'] as String
                  })
              .toList() ??
          [],
    );
  }
}
