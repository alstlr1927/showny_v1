class GetMyShoppingResponseModel {
  GetMyShoppingResponseModel({
     this.success,
     this.data,
  });
   bool? success;
   List<Data>? data;

  GetMyShoppingResponseModel.fromJson(Map<String, dynamic> json){
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
     this.chargeCnt,
     this.deliveryCnt,
     this.confirmedCnt,
     this.point,
     this.couponCnt,
  });
   String? chargeCnt;
   String? deliveryCnt;
   String? confirmedCnt;
   String? point;
   String? couponCnt;

  Data.fromJson(Map<String, dynamic> json){
    chargeCnt = json['chargeCnt'];
    deliveryCnt = json['deliveryCnt'];
    confirmedCnt = json['confirmedCnt'];
    point = json['point'];
    couponCnt = json['couponCnt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['chargeCnt'] = chargeCnt;
    _data['deliveryCnt'] = deliveryCnt;
    _data['confirmedCnt'] = confirmedCnt;
    _data['point'] = point;
    _data['couponCnt'] = couponCnt;
    return _data;
  }
}