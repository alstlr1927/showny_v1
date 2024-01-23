class GetBannerListResponseModel {
  GetBannerListResponseModel({
     this.success,
     this.data,
  });
   bool? success;
    List<Data>? data;

  GetBannerListResponseModel.fromJson(Map<String, dynamic> json){
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
     this.bannerNo,
     this.type,
     this.title,
     this.bannerImg,
     this.createdAt,
  });
   String? bannerNo;
    String? type;
   String? title;
   String? bannerImg;
   String? createdAt;

  Data.fromJson(Map<String, dynamic> json){
    bannerNo = json['bannerNo'];
    type = json['type'];
    title = json['title'];
    bannerImg = json['bannerImg'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bannerNo'] = bannerNo;
    _data['type'] = type;
    _data['title'] = title;
    _data['bannerImg'] = bannerImg;
    _data['created_at'] = createdAt;
    return _data;
  }
}
