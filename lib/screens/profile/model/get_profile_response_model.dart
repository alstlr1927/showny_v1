class GetProfileResponseModel {
  GetProfileResponseModel({
     this.success,
     this.data,
  });
   bool? success;
   Data? data;

  GetProfileResponseModel.fromJson(Map<String, dynamic> json){
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
     this.memNo,
     this.memId,
     this.memNm,
     this.nickNm,
     this.gender,
     this.birthday,
     this.email,
     this.phone,
     this.profileImage,
     this.introduce,
     this.heightId,
     this.weightId,
     this.bodyShapeId,
     this.styleIdList,
     this.colorIdList,
     this.postCount,
     this.followerCount,
     this.followCount,
     this.isFollow,
  });
   String? memNo;
   String? memId;
   String? memNm;
   String? nickNm;
   int? gender;
   String? birthday;
   String? email;
   String? phone;
   String? profileImage;
   String? introduce;
   int? heightId;
   int? weightId;
   int? bodyShapeId;
   List<int>? styleIdList;
   List<int>? colorIdList;
   int? postCount;
   int? followerCount;
   int? followCount;
   bool? isFollow;

  Data.fromJson(Map<String, dynamic> json){
    memNo = json['memNo'];
    memId = json['memId'];
    memNm = json['memNm'];
    nickNm = json['nickNm'];
    gender = json['gender'];
    birthday = json['birthday'];
    email = json['email'];
    phone = json['phone'];
    profileImage = json['profileImage'];
    introduce = json['introduce'];
    heightId = json['heightId'];
    weightId = json['weightId'];
    bodyShapeId = json['bodyShapeId'];
    styleIdList = List.castFrom<dynamic, int>(json['styleIdList']);
    colorIdList = List.castFrom<dynamic, int>(json['colorIdList']);
    postCount = json['postCount'];
    followerCount = json['followerCount'];
    followCount = json['followCount'];
    isFollow = json['isFollow'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['memNo'] = memNo;
    _data['memId'] = memId;
    _data['memNm'] = memNm;
    _data['nickNm'] = nickNm;
    _data['gender'] = gender;
    _data['birthday'] = birthday;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['profileImage'] = profileImage;
    _data['introduce'] = introduce;
    _data['heightId'] = heightId;
    _data['weightId'] = weightId;
    _data['bodyShapeId'] = bodyShapeId;
    _data['styleIdList'] = styleIdList;
    _data['colorIdList'] = colorIdList;
    _data['postCount'] = postCount;
    _data['followerCount'] = followerCount;
    _data['followCount'] = followCount;
    _data['isFollow'] = isFollow;
    return _data;
  }
}