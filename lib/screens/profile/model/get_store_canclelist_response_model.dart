class GetStoreCancelListModel {
  GetStoreCancelListModel({
     this.success,
     this.data,
  });
   bool? success;
   List<Data>? data;

  GetStoreCancelListModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
     this.orderNo,
     this.totalGoodsPrice,
     this.totalDeliveryCharge,
     this.settlePrice,
     this.orderGoods,
  });
   String? orderNo;
   String? totalGoodsPrice;
   String? totalDeliveryCharge;
   String? settlePrice;
   List<OrderGoods>? orderGoods;

  Data.fromJson(Map<String, dynamic> json){
    orderNo = json['orderNo'];
    totalGoodsPrice = json['totalGoodsPrice'];
    totalDeliveryCharge = json['totalDeliveryCharge'];
    settlePrice = json['settlePrice'];
    orderGoods = List.from(json['orderGoods']).map((e)=>OrderGoods.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orderNo'] = orderNo;
    _data['totalGoodsPrice'] = totalGoodsPrice;
    _data['totalDeliveryCharge'] = totalDeliveryCharge;
    _data['settlePrice'] = settlePrice;
    _data['orderGoods'] = orderGoods!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class OrderGoods {
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
   String? orderGoodsNo;
   String? goodsNo;
   String? goodsNm;
   String? optionSno;
   String? goodsCnt;
   String? brandNm;
   String? goodsImgUrl;
   String? orderStatus;

  OrderGoods.fromJson(Map<String, dynamic> json){
    orderGoodsNo = json['orderGoodsNo'];
    goodsNo = json['goodsNo'];
    goodsNm = json['goodsNm'];
    optionSno = json['optionSno'];
    goodsCnt = json['goodsCnt'];
    brandNm = json['brandNm'];
    goodsImgUrl = json['goodsImgUrl'];
    orderStatus = json['orderStatus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orderGoodsNo'] = orderGoodsNo;
    _data['goodsNo'] = goodsNo;
    _data['goodsNm'] = goodsNm;
    _data['optionSno'] = optionSno;
    _data['goodsCnt'] = goodsCnt;
    _data['brandNm'] = brandNm;
    _data['goodsImgUrl'] = goodsImgUrl;
    _data['orderStatus'] = orderStatus;
    return _data;
  }
}