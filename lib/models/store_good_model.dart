import 'package:showny/main.dart';
import 'package:showny/models/goods_option_model.dart';

class StoreGoodModel {
  String goodsNo;
  String goodsNm;
  int goodsPrice;
  int goodsDiscount;
  List<String> goodsImageUrlList;
  String brandNm;
  String brandCd;
  String brandImgUrl;
  bool isHeart;
  int heartCount;
  int reviewCount;
  double grade;
  String goodsDescription;
  String memberRequestLink;
  // List<List<Map<String, String>>> options;
  List<GoodsOptionModel> optionList;
  String productGuideInfo;
  List<Map<String, String>> productNoticeInfo;
  List<Map<String, String>> sellerInfo;
  double left;
  double top;

  StoreGoodModel({
    this.goodsNo = "",
    this.goodsNm = "",
    this.goodsPrice = 0,
    this.goodsDiscount = 0,
    this.goodsImageUrlList = const [],
    this.brandNm = "",
    this.brandCd = "",
    this.brandImgUrl = "",
    this.memberRequestLink = "",
    this.isHeart = false,
    this.heartCount = 0,
    this.reviewCount = 0,
    this.grade = 0.0,
    this.goodsDescription = "",
    this.optionList = const [],
    this.productGuideInfo = "",
    this.productNoticeInfo = const [],
    this.sellerInfo = const [],
    this.left = 0,
    this.top = 0,
  }) {
    eventBus.on<StoreGoodModel>().listen((event) {
      if (event.goodsNo == goodsNo) {
        goodsNm = event.goodsNm;
        goodsPrice = event.goodsPrice;
        goodsDiscount = event.goodsDiscount;
        goodsImageUrlList = event.goodsImageUrlList;
        brandNm = event.brandNm;
        brandCd = event.brandCd;
        brandImgUrl = event.brandImgUrl;
        isHeart = event.isHeart;
        heartCount = event.heartCount;
        reviewCount = event.reviewCount;
        grade = event.grade;
        goodsDescription = event.goodsDescription;
        memberRequestLink = event.memberRequestLink;
        optionList = event.optionList;
        productGuideInfo = event.productGuideInfo;
        productNoticeInfo = event.productNoticeInfo;
        sellerInfo = event.sellerInfo;
        left = event.left;
        top = event.top;
      }
    });
  }

  factory StoreGoodModel.fromJson(Map<String, dynamic> json) {
    var goodsOptionList = (json['optionList'] as List)
        .map((item) => GoodsOptionModel.fromJson(item))
        .toList();

    return StoreGoodModel(
      goodsNo: json['goodsNo'] as String? ?? "",
      goodsNm: json['goodsNm'] as String? ?? "",
      goodsPrice: json['goodsPrice'] as int? ?? 0,
      goodsDiscount: json['goodsDiscount'] as int? ?? 0,
      goodsImageUrlList: List<String>.from(json['goodsImageUrlList'] ?? []),
      brandNm: json['brandNm'] as String? ?? "",
      brandCd: json['brandCd'] as String? ?? "",
      brandImgUrl: json['brandImgUrl'] as String? ?? "",
      isHeart: json['isHeart'] as bool? ?? false,
      heartCount: json['heartCount'] as int? ?? 0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      grade: double.parse(json['grade'] as String? ?? "0"),
      goodsDescription: json['goodsDescription'] as String? ?? "",
      memberRequestLink: json['memberRequestLink'] as String? ?? "",
      // options: (json['options'] as List<dynamic>?)
      // ?.map<List<Map<String, String>>>((innerList) =>
      //     (innerList as List<dynamic>)
      //         .map<Map<String, String>>((innerMap) =>
      //             innerMap is Map<String, dynamic> ? innerMap.cast<String, String>() : {})
      //         .toList())
      // .toList() ?? [],
      optionList: goodsOptionList,
      productGuideInfo: json['productGuideInfo'] as String? ?? "",
      productNoticeInfo: (json['productNoticeInfo'] as List<dynamic>?)
              ?.map((notice) => {
                    'key': notice['key'] as String? ?? "",
                    'value': notice['value'] as String? ?? ""
                  })
              .toList() ??
          [],
      sellerInfo: (json['sellerInfo'] as List<dynamic>?)
              ?.map((seller) => {
                    'key': seller['key'] as String? ?? "",
                    'value': seller['value'] as String? ?? ""
                  })
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goodsNo': goodsNo,
      'goodsNm': goodsNm,
      'goodsPrice': goodsPrice,
      'goodsDiscount': goodsDiscount,
      'goodsImageUrlList': goodsImageUrlList,
      'brandNm': brandNm,
      'brandCd': brandCd,
      'brandImgUrl': brandImgUrl,
      'heartCount': heartCount,
      'reviewCount': reviewCount,
      'grade': grade.toString(),
      'goodsDescription': goodsDescription,
      'memberRequestLink': memberRequestLink,
      // 'options': options.map((optionList) => optionList.map((option) => option).toList()).toList(),
      'optionList': optionList,
      'productGuideInfo': productGuideInfo,
      'productNoticeInfo': productNoticeInfo,
      'sellerInfo': sellerInfo,
      'left': left,
      'top': top,
    };
  }

  StoreGoodModel.clone(StoreGoodModel source)
      : goodsNo = source.goodsNo,
        goodsNm = source.goodsNm,
        goodsPrice = source.goodsPrice,
        goodsDiscount = source.goodsDiscount,
        goodsImageUrlList = List<String>.from(source.goodsImageUrlList),
        brandNm = source.brandNm,
        brandCd = source.brandCd,
        brandImgUrl = source.brandImgUrl,
        isHeart = source.isHeart,
        heartCount = source.heartCount,
        reviewCount = source.reviewCount,
        grade = source.grade,
        goodsDescription = source.goodsDescription,
        memberRequestLink = source.memberRequestLink,
        optionList = source.optionList
            .map((option) => GoodsOptionModel.clone(option))
            .toList(),
        productGuideInfo = source.productGuideInfo,
        productNoticeInfo = source.productNoticeInfo
            .map((e) => Map<String, String>.from(e))
            .toList(),
        sellerInfo =
            source.sellerInfo.map((e) => Map<String, String>.from(e)).toList(),
        left = source.left,
        top = source.top;
}
