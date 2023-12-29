class GetStoreCancelInfoDetailModel {
  GetStoreCancelInfoDetailModel({
     this.success,
     this.data,
  });
   bool? success;
   Data? data;

  GetStoreCancelInfoDetailModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
     this.orderInfo,
     this.goodsInfo,
     this.orderStatus,
     this.chargeInfo,
     this.receiverInfo,
  });
   OrderInfo? orderInfo;
   List<GoodsInfo>? goodsInfo;
   String? orderStatus;
   ChargeInfo? chargeInfo;
   ReceiverInfo? receiverInfo;

  Data.fromJson(Map<String, dynamic> json){
    orderInfo = OrderInfo.fromJson(json['orderInfo']);
    goodsInfo = List.from(json['goodsInfo']).map((e)=>GoodsInfo.fromJson(e)).toList();
    orderStatus = json['orderStatus'];
    chargeInfo = ChargeInfo.fromJson(json['chargeInfo']);
    receiverInfo = ReceiverInfo.fromJson(json['receiverInfo']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orderInfo'] = orderInfo!.toJson();
    _data['goodsInfo'] = goodsInfo!.map((e)=>e.toJson()).toList();
    _data['orderStatus'] = orderStatus;
    _data['chargeInfo'] = chargeInfo!.toJson();
    _data['receiverInfo'] = receiverInfo!.toJson();
    return _data;
  }
}

class OrderInfo {
  OrderInfo({
     this.orderNo,
     this.regDt,
     this.orderName,
     this.settlePrice,
     this.totalGoodsMileage,
  });
   String? orderNo;
   String? regDt;
   String? orderName;
   String? settlePrice;
   String? totalGoodsMileage;

  OrderInfo.fromJson(Map<String, dynamic> json){
    orderNo = json['orderNo'];
    regDt = json['regDt'];
    orderName = json['orderName'];
    settlePrice = json['settlePrice'];
    totalGoodsMileage = json['totalGoodsMileage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orderNo'] = orderNo;
    _data['regDt'] = regDt;
    _data['orderName'] = orderName;
    _data['settlePrice'] = settlePrice;
    _data['totalGoodsMileage'] = totalGoodsMileage;
    return _data;
  }
}

class GoodsInfo {
  GoodsInfo({
     this.goodsNm,
     this.optionInfo,
     this.goodsCnt,
     this.brandNm,
    this.goodsImageUrl,
  });
   String? goodsNm;
   String? optionInfo;
   String? goodsCnt;
   String? brandNm;
   String? goodsImageUrl;

  GoodsInfo.fromJson(Map<String, dynamic> json){
    goodsNm = json['goodsNm'];
    optionInfo = json['optionInfo'];
    goodsCnt = json['goodsCnt'];
    brandNm = json['brandNm'];
    goodsImageUrl = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['goodsNm'] = goodsNm;
    _data['optionInfo'] = optionInfo;
    _data['goodsCnt'] = goodsCnt;
    _data['brandNm'] = brandNm;
    _data['goodsImageUrl'] = goodsImageUrl;
    return _data;
  }
}

class ChargeInfo {
  ChargeInfo({
     this.chargeMethod,
     this.totalGoodsPrice,
     this.totalCouponGoodsDcPrice,
     this.useMileage,
     this.totalDeliveryCharge,
     this.settlePrice,
  });
   String? chargeMethod;
   String? totalGoodsPrice;
   String? totalCouponGoodsDcPrice;
   String? useMileage;
   String? totalDeliveryCharge;
   String? settlePrice;

  ChargeInfo.fromJson(Map<String, dynamic> json){
    chargeMethod = json['chargeMethod'];
    totalGoodsPrice = json['totalGoodsPrice'];
    totalCouponGoodsDcPrice = json['totalCouponGoodsDcPrice'];
    useMileage = json['useMileage'];
    totalDeliveryCharge = json['totalDeliveryCharge'];
    settlePrice = json['settlePrice'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['chargeMethod'] = chargeMethod;
    _data['totalGoodsPrice'] = totalGoodsPrice;
    _data['totalCouponGoodsDcPrice'] = totalCouponGoodsDcPrice;
    _data['useMileage'] = useMileage;
    _data['totalDeliveryCharge'] = totalDeliveryCharge;
    _data['settlePrice'] = settlePrice;
    return _data;
  }
}

class ReceiverInfo {
  ReceiverInfo({
     this.orderName,
     this.orderCellPhone,
     this.receiverZonecode,
     this.receiverAddress,
     this.receiverAddressSub,
     this.orderMemo,
  });
   String? orderName;
   String? orderCellPhone;
   String? receiverZonecode;
   String? receiverAddress;
   String? receiverAddressSub;
   String? orderMemo;

  ReceiverInfo.fromJson(Map<String, dynamic> json){
    orderName = json['orderName'];
    orderCellPhone = json['orderCellPhone'];
    receiverZonecode = json['receiverZonecode'];
    receiverAddress = json['receiverAddress'];
    receiverAddressSub = json['receiverAddressSub'];
    orderMemo = json['orderMemo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orderName'] = orderName;
    _data['orderCellPhone'] = orderCellPhone;
    _data['receiverZonecode'] = receiverZonecode;
    _data['receiverAddress'] = receiverAddress;
    _data['receiverAddressSub'] = receiverAddressSub;
    _data['orderMemo'] = orderMemo;
    return _data;
  }
}