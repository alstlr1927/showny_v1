class StyleupItemInfoModel {
  String goodsNo;
  String goodsNm;
  String goodsPrice;
  String brandNm;
  String goodsImgUrl;

  StyleupItemInfoModel({
    this.goodsNo = "",
    this.goodsNm = "",
    this.goodsPrice = "",
    this.brandNm = "",
    this.goodsImgUrl = "",
  });

  factory StyleupItemInfoModel.fromJson(Map<String, dynamic> json) {
    return StyleupItemInfoModel(
      goodsNo: json['goodsNo'] ?? "",
      goodsNm: json['goodsNm'] as String,
      goodsPrice: json['goodsPrice'] as String,
      brandNm: json['brandNm'] as String,
      goodsImgUrl: json['goodsImgUrl'] as String,
    );
  }
}