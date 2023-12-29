// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

STUResponse _$STUResponseFromJson(Map<String, dynamic> json) => STUResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => STUData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$STUResponseToJson(STUResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

STUData _$STUDataFromJson(Map<String, dynamic> json) => STUData(
      styleupNo: json['styleupNo'] as String,
      memNo: json['memNo'] as String,
      type: json['type'] as String,
      imgUrlList: (json['imgUrlList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      description: json['description'] as String,
      styleList: (json['styleList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      colorList: (json['colorList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      season: json['season'] as String,
      itemOuter: (json['itemOuter'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemTop: (json['itemTop'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemPants: (json['itemPants'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemShoes: (json['itemShoes'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemBag: (json['itemBag'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemAccessory: (json['itemAccessory'] as List<dynamic>?)
          ?.map((e) => ItemTagList.fromJson(e as Map<String, dynamic>))
          .toList(),
      nickNm: json['nickNm'] as String?,
      upDownType: json['upDownType'] as int,
      userInfo: json['userInfo'] == null
          ? null
          : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      itemInfo: json['itemInfo'] == null
          ? null
          : ItemInfo.fromJson(json['itemInfo'] as Map<String, dynamic>),
      styleupList: (json['styleupList'] as List<dynamic>?)
          ?.map((e) => STUData.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: json['price'] as int?,
      isBookmark: json['isBookmark'] as bool?,
    );

Map<String, dynamic> _$STUDataToJson(STUData instance) => <String, dynamic>{
      'styleupNo': instance.styleupNo,
      'memNo': instance.memNo,
      'type': instance.type,
      'imgUrlList': instance.imgUrlList,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'styleList': instance.styleList,
      'colorList': instance.colorList,
      'season': instance.season,
      'itemOuter': instance.itemOuter,
      'itemTop': instance.itemTop,
      'itemPants': instance.itemPants,
      'itemShoes': instance.itemShoes,
      'itemBag': instance.itemBag,
      'itemAccessory': instance.itemAccessory,
      'nickNm': instance.nickNm,
      'upDownType': instance.upDownType,
      'itemInfo': instance.itemInfo,
      'styleupList': instance.styleupList,
      'price': instance.price,
      'userInfo': instance.userInfo,
      'isBookmark': instance.isBookmark,
    };

ItemTagList _$ItemTagListFromJson(Map<String, dynamic> json) => ItemTagList(
      itemTagList: (json['itemTagList'] as List<dynamic>?)
          ?.map((e) => ItemTagListComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemTagListToJson(ItemTagList instance) =>
    <String, dynamic>{
      'itemTagList': instance.itemTagList,
    };

ItemTagListComponent _$ItemTagListComponentFromJson(
        Map<String, dynamic> json) =>
    ItemTagListComponent(
      goodsNo: json['goodsNo'] as int?,
      goodsSize: json['goodsSize'] as String?,
      left: json['left'] as int?,
      top: json['top'] as int?,
      goodsPrice: json['goodsPrice'] as int?,
    );

Map<String, dynamic> _$ItemTagListComponentToJson(
        ItemTagListComponent instance) =>
    <String, dynamic>{
      'goodsNo': instance.goodsNo,
      'goodsSize': instance.goodsSize,
      'left': instance.left,
      'top': instance.top,
      'goodsPrice': instance.goodsPrice,
    };

ItemInfo _$ItemInfoFromJson(Map<String, dynamic> json) => ItemInfo(
      goodsNo: json['goodsNo'] as String,
      goodsNm: json['goodsNm'] as String,
      brandNm: json['brandNm'] as String?,
      goodsImgUrl: json['goodsImgUrl'] as String?,
    );

Map<String, dynamic> _$ItemInfoToJson(ItemInfo instance) => <String, dynamic>{
      'goodsNo': instance.goodsNo,
      'goodsNm': instance.goodsNm,
      'brandNm': instance.brandNm,
      'goodsImgUrl': instance.goodsImgUrl,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      memNo: json['memNo'] as String?,
      memId: json['memId'] as String?,
      memNm: json['memNm'] as String?,
      nickNm: json['nickNm'] as String?,
      gender: json['gender'] as int?,
      birthday: json['birthday'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profileImage'] as String?,
      introduce: json['introduce'] as String?,
      heightId: json['heightId'] as int?,
      weightId: json['weightId'] as int?,
      bodyShapeId: json['bodyShapeId'] as int?,
      styleIdList: (json['styleIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      colorIdList: (json['colorIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      postCount: json['postCount'] as int?,
      followerCount: json['followerCount'] as int?,
      followCount: json['followCount'] as int?,
      isFollow: json['isFollow'] as bool?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'memNo': instance.memNo,
      'memId': instance.memId,
      'memNm': instance.memNm,
      'nickNm': instance.nickNm,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'introduce': instance.introduce,
      'heightId': instance.heightId,
      'weightId': instance.weightId,
      'bodyShapeId': instance.bodyShapeId,
      'styleIdList': instance.styleIdList,
      'colorIdList': instance.colorIdList,
      'postCount': instance.postCount,
      'followerCount': instance.followerCount,
      'followCount': instance.followCount,
      'isFollow': instance.isFollow,
    };
