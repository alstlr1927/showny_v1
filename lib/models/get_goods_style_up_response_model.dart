class GetGoodsStyleUpResponseModel {
  GetGoodsStyleUpResponseModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  GetGoodsStyleUpResponseModel.fromJson(Map<String, dynamic> json) {
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
    this.styleupData,
    this.styleupCount,
  });

  List<StyleupData>? styleupData;
  int? styleupCount;

  Data.fromJson(Map<String, dynamic> json) {
    styleupData = List.from(json['styleupData'])
        .map((e) => StyleupData.fromJson(e))
        .toList();
    styleupCount = json['styleupCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['styleupData'] = styleupData!.map((e) => e.toJson()).toList();
    _data['styleupCount'] = styleupCount;
    return _data;
  }
}

class StyleupData {
  StyleupData({
    this.styleupNo,
    this.memNo,
    this.type,
    this.imgUrlList,
    this.videoUrl,
    this.thumbnailUrl,
    this.description,
    this.styleList,
    this.colorList,
    this.season,
    this.itemOuter,
    this.itemTop,
    this.itemPants,
    this.itemShoes,
    this.itemBag,
    this.itemAccessory,
    this.isBookmark,
    this.upDownType,
    this.heartCount,
    this.commentCount,
    this.itemInfo,
    this.userInfo,
  });

  String? styleupNo;
  String? memNo;
  String? type;
  List<String>? imgUrlList;
  String? videoUrl;
  String? thumbnailUrl;
  String? description;
  List<dynamic>? styleList;
  List<dynamic>? colorList;
  String? season;
  List<ItemOuter>? itemOuter;
  List<ItemTop>? itemTop;
  List<ItemPants>? itemPants;
  List<ItemShoes>? itemShoes;
  List<ItemBag>? itemBag;
  List<ItemAccessory>? itemAccessory;
  bool? isBookmark;
  int? upDownType;
  int? heartCount;
  int? commentCount;
  ItemInfo? itemInfo;
  UserInfo? userInfo;

  StyleupData.fromJson(Map<String, dynamic> json) {
    styleupNo = json['styleupNo'];
    memNo = json['memNo'];
    type = json['type'];
    imgUrlList = List.castFrom<dynamic, String>(json['imgUrlList']);
    videoUrl = json['videoUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    description = json['description'];
    styleList = List.castFrom<dynamic, dynamic>(json['styleList']);
    colorList = List.castFrom<dynamic, dynamic>(json['colorList']);
    season = json['season'];
    itemOuter =
        List.from(json['itemOuter']).map((e) => ItemOuter.fromJson(e)).toList();
    itemTop =
        List.from(json['itemTop']).map((e) => ItemTop.fromJson(e)).toList();
    itemPants =
        List.from(json['itemPants']).map((e) => ItemPants.fromJson(e)).toList();
    itemShoes =
        List.from(json['itemShoes']).map((e) => ItemShoes.fromJson(e)).toList();
    itemBag =
        List.from(json['itemBag']).map((e) => ItemBag.fromJson(e)).toList();
    itemAccessory = List.from(json['itemAccessory'])
        .map((e) => ItemAccessory.fromJson(e))
        .toList();
    isBookmark = json['isBookmark'];
    upDownType = json['upDownType'];
    heartCount = json['heartCount'];
    commentCount = json['commentCount'];
    itemInfo = null;
    userInfo = UserInfo.fromJson(json['userInfo']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['styleupNo'] = styleupNo;
    _data['memNo'] = memNo;
    _data['type'] = type;
    _data['imgUrlList'] = imgUrlList;
    _data['videoUrl'] = videoUrl;
    _data['thumbnailUrl'] = thumbnailUrl;
    _data['description'] = description;
    _data['styleList'] = styleList;
    _data['colorList'] = colorList;
    _data['season'] = season;
    _data['itemOuter'] = itemOuter!.map((e) => e.toJson()).toList();
    _data['itemTop'] = itemTop!.map((e) => e.toJson()).toList();
    _data['itemPants'] = itemPants!.map((e) => e.toJson()).toList();
    _data['itemShoes'] = itemShoes!.map((e) => e.toJson()).toList();
    _data['itemBag'] = itemBag!.map((e) => e.toJson()).toList();
    _data['itemAccessory'] = itemAccessory!.map((e) => e.toJson()).toList();
    _data['isBookmark'] = isBookmark;
    _data['upDownType'] = upDownType;
    _data['heartCount'] = heartCount;
    _data['commentCount'] = commentCount;
    _data['itemInfo'] = itemInfo;
    _data['userInfo'] = userInfo!.toJson();
    return _data;
  }
}

class ItemOuter {
  ItemOuter({
    this.itemTagList,
  });

  List<ItemTagList>? itemTagList;

  ItemOuter.fromJson(Map<String, dynamic> json) {
    itemTagList = List.from(json['itemTagList'])
        .map((e) => ItemTagList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['itemTagList'] = itemTagList!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ItemTagList {
  ItemTagList({
    this.goodsNo,
    this.goodsSize,
    this.goodsPrice,
    this.left,
    this.top,
  });

  int? goodsNo;
  String? goodsSize;
  int? goodsPrice;
  int? left;
  int? top;

  ItemTagList.fromJson(Map<String, dynamic> json) {
    goodsNo = json['goodsNo'];
    goodsSize = json['goodsSize'];
    goodsPrice = json['goodsPrice'];
    left = json['left'];
    top = json['top'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['goodsNo'] = goodsNo;
    _data['goodsSize'] = goodsSize;
    _data['goodsPrice'] = goodsPrice;
    _data['left'] = left;
    _data['top'] = top;
    return _data;
  }
}

class ItemTop {
  ItemTop({
    this.itemTagList,
  });

  List<ItemTagList>? itemTagList;

  ItemTop.fromJson(Map<String, dynamic> json) {
    itemTagList = List.from(json['itemTagList'])
        .map((e) => ItemTagList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['itemTagList'] = itemTagList!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ItemPants {
  ItemPants({
    this.itemTagList,
  });

  List<ItemTagList>? itemTagList;

  ItemPants.fromJson(Map<String, dynamic> json) {
    itemTagList = List.from(json['itemTagList'])
        .map((e) => ItemTagList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['itemTagList'] = itemTagList!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ItemShoes {
  ItemShoes({
    this.itemTagList,
  });

  List<ItemTagList>? itemTagList;

  ItemShoes.fromJson(Map<String, dynamic> json) {
    itemTagList = List.from(json['itemTagList'])
        .map((e) => ItemTagList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['itemTagList'] = itemTagList!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ItemBag {
  ItemBag({
    this.itemTagList,
  });

  List<ItemTagList>? itemTagList;

  ItemBag.fromJson(Map<String, dynamic> json) {
    itemTagList = List.from(json['itemTagList'])
        .map((e) => ItemTagList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['itemTagList'] = itemTagList!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ItemAccessory {
  ItemAccessory({
    this.itemTagList,
  });

  List<ItemTagList>? itemTagList;

  ItemAccessory.fromJson(Map<String, dynamic> json) {
    itemTagList = List.from(json['itemTagList'])
        .map((e) => ItemTagList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['itemTagList'] = itemTagList!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ItemInfo {
  ItemInfo({
    this.goodsNo,
    this.goodsNm,
    this.goodsPrice,
    this.brandNm,
    this.goodsImgUrl,
  });

  String? goodsNo;
  String? goodsNm;
  String? goodsPrice;
  String? brandNm;
  String? goodsImgUrl;

  ItemInfo.fromJson(Map<String, dynamic> json) {
    goodsNo = json['goodsNo'];
    goodsNm = json['goodsNm'];
    goodsPrice = json['goodsPrice'];
    brandNm = json['brandNm'];
    goodsImgUrl = json['goodsImgUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['goodsNo'] = goodsNo;
    _data['goodsNm'] = goodsNm;
    _data['goodsPrice'] = goodsPrice;
    _data['brandNm'] = brandNm;
    _data['goodsImgUrl'] = goodsImgUrl;
    return _data;
  }
}

class UserInfo {
  UserInfo({
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

  UserInfo.fromJson(Map<String, dynamic> json) {
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
