class GoodsItemModel {
  int contentIndex = 0;
  int categoryId = 0;
  String goodsNo = "";
  String goodsNm = "";
  String goodsImg = "";
  int goodsPrice = 0;
  String brandNm = "";
  String optionKey = "";
  String optionValue = "";
  double left = 0;
  double top = 0;

  GoodsItemModel({
    this.contentIndex = 0,
    this.categoryId = 0,
    this.goodsNo = "",
    this.goodsNm = "",
    this.goodsImg = "",
    this.goodsPrice = 0,
    this.brandNm = "",
    this.left = 0,
    this.top = 0,
    this.optionKey = "",
    this.optionValue = ""
  });

  Map<String, dynamic> toJson() {
    return {
      'contentIndex': contentIndex,
      'categoryId': categoryId,
      'goodsNo': goodsNo,
      'goodsNm': goodsNm,
      'goodsImg': goodsImg,
      'goodsPrice': goodsPrice,
      'brandNm': brandNm,
      'optionKey': optionKey,
      'optionValue': optionValue,
      'left': left,
      'top': top,
    };
  }

  factory GoodsItemModel.fromJson(Map<String, dynamic> json) {
    return GoodsItemModel(
      contentIndex: json['contentIndex'] as int? ?? 0,
      categoryId: json['categoryId'] as int? ?? 0,
      goodsNo: json['goodsNo'] as String? ?? "",
      goodsNm: json['goodsNm'] as String? ?? "",
      goodsPrice: json['goodsPrice'] as int? ?? 0,
      goodsImg: json['goodsImg'] as String? ?? "",
      brandNm: json['brandNm'] as String? ?? "",
      optionKey: json['optionKey'] as String? ?? "",
      optionValue: json['optionValue'] as String? ?? "",
      left: json['left'] as double? ?? 0,
      top: json['top'] as double? ?? 0,
    );
  }
}