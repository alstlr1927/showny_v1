class GetStoreCartListResponseModel {
  GetStoreCartListResponseModel({
     this.success,
     this.data,
  });
   bool? success;
   List<Data>? data;

  GetStoreCartListResponseModel.fromJson(Map<String, dynamic> json){
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
     this.cartNo,
     this.goodsNo,
     this.goodsImgUrl,
     this.goodsNm,
     this.brandNm,
     this.goodsCnt,
     this.goodsPrice,
     this.deliveryPrice,
  });
   String? cartNo;
   String? goodsNo;
   String? goodsImgUrl;
   String? goodsNm;
   String? brandNm;
   String? goodsCnt;
   String? goodsPrice;
   String? deliveryPrice;
  bool? isSelected;

  Data.fromJson(Map<String, dynamic> json){
    cartNo = json['cartNo'];
    goodsNo = json['goodsNo'];
    goodsImgUrl = json['goodsImgUrl'];
    goodsNm = json['goodsNm'];
    brandNm = json['brandNm'];
    goodsCnt = json['goodsCnt'];
    goodsPrice = json['goodsPrice'];
    deliveryPrice = json['deliveryPrice'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cartNo'] = cartNo;
    _data['goodsNo'] = goodsNo;
    _data['goodsImgUrl'] = goodsImgUrl;
    _data['goodsNm'] = goodsNm;
    _data['brandNm'] = brandNm;
    _data['goodsCnt'] = goodsCnt;
    _data['goodsPrice'] = goodsPrice;
    _data['deliveryPrice'] = deliveryPrice;
    _data['isSelected'] = isSelected;
    return _data;
  }
}