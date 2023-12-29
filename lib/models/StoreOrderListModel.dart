class StoreOrderListResponse {
  bool? success;
  Data? data;

  StoreOrderListResponse({this.success, this.data});

  factory StoreOrderListResponse.fromJson(Map<String, dynamic> json) => StoreOrderListResponse(
    success: json['success'],
    data: json['data'] != null ? Data.fromJson(json['data']) : null,
  );
}

class Data {
  List<ExchangeList>? exchangeList;

  Data({this.exchangeList});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    exchangeList: json['exchangeList'] != null
        ? List<ExchangeList>.from(json['exchangeList'].map((x) => ExchangeList.fromJson(x)))
        : null,
  );
}

class ExchangeList {
  String? orderNo;
  String? totalGoodsPrice;
  String? totalDeliveryCharge;
  String? settlePrice;
  List<OrderGoods>? orderGoods;

  ExchangeList({this.orderNo, this.totalGoodsPrice, this.totalDeliveryCharge, this.settlePrice, this.orderGoods});

  factory ExchangeList.fromJson(Map<String, dynamic> json) => ExchangeList(
    orderNo: json['orderNo'],
    totalGoodsPrice: json['totalGoodsPrice'],
    totalDeliveryCharge: json['totalDeliveryCharge'],
    settlePrice: json['settlePrice'],
    orderGoods: json['orderGoods'] != null
        ? List<OrderGoods>.from(json['orderGoods'].map((x) => OrderGoods.fromJson(x)))
        : null,
  );
}

class OrderGoods {
  String? orderGoodsNo;
  String? goodsNo;
  String? goodsNm;
  String? optionSno;
  String? goodsCnt;
  String? brandNm;
  String? goodsImgUrl;
  String? orderStatus;

  OrderGoods({
    this.orderGoodsNo,
    this.goodsNo,
    this.goodsNm,
    this.optionSno,
    this.goodsCnt,
    this.brandNm,
    this.goodsImgUrl,
    this.orderStatus,
  });

  factory OrderGoods.fromJson(Map<String, dynamic> json) => OrderGoods(
    orderGoodsNo: json['orderGoodsNo'],
    goodsNo: json['goodsNo'],
    goodsNm: json['goodsNm'],
    optionSno: json['optionSno'],
    goodsCnt: json['goodsCnt'],
    brandNm: json['brandNm'],
    goodsImgUrl: json['goodsImgUrl'],
    orderStatus: json['orderStatus'],
  );
}
