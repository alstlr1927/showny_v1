  import 'package:json_annotation/json_annotation.dart';

  part 'style_up_response.g.dart';

  @JsonSerializable()
  class STUResponse {
    STUResponse({
      required this.success,
      this.data,
    });

    bool success;
    List<STUData>? data;

    factory STUResponse.fromJson(Map<String, dynamic> json) =>
        _$STUResponseFromJson(json);

    Map<String, dynamic> toJson() => _$STUResponseToJson(this);
  }

  @JsonSerializable()
  class STUData {
    STUData({
      required this.styleupNo,
      required this.memNo,
      required this.type,
      required this.imgUrlList,
      required this.videoUrl,
      required this.thumbnailUrl,
      required this.description,
      required this.styleList,
      required this.colorList,
      required this.season,
      required this.itemOuter,
      required this.itemTop,
      required this.itemPants,
      required this.itemShoes,
      required this.itemBag,
      required this.itemAccessory,
      required this.nickNm,
      required this.upDownType,
      this.userInfo,
      this.itemInfo,
      this.styleupList,
      this.price,
      this.isBookmark,
    });

    String styleupNo;
    String memNo;
    String type;
    List<String>? imgUrlList;
    String videoUrl;
    String thumbnailUrl;
    String description;
    List<String>? styleList;
    List<String>? colorList;
    String season;
    List<ItemTagList>? itemOuter = [];
    List<ItemTagList>? itemTop;
    List<ItemTagList>? itemPants;
    List<ItemTagList>? itemShoes;
    List<ItemTagList>? itemBag;
    List<ItemTagList>? itemAccessory;
    String? nickNm;
    int upDownType;
    ItemInfo? itemInfo;
    List<STUData>? styleupList;
    int? price;
    UserInfo? userInfo;
    bool? isBookmark;

    factory STUData.fromJson(Map<String, dynamic> json) =>
        _$STUDataFromJson(json);

    Map<String, dynamic> toJson() => _$STUDataToJson(this);
  }

  @JsonSerializable()
  class ItemTagList {
    final List<ItemTagListComponent>? itemTagList; // nullable로 변경

    ItemTagList({
      this.itemTagList, // nullable로 변경
    });

    factory ItemTagList.fromJson(Map<String, dynamic> json) =>
        _$ItemTagListFromJson(json);

    Map<String, dynamic> toJson() => _$ItemTagListToJson(this);
  }

  @JsonSerializable()
  class ItemTagListComponent {
    ItemTagListComponent({
      required this.goodsNo,
      required this.goodsSize,
      required this.left,
      required this.top,
      required this.goodsPrice,
    });

    int? goodsNo;
    String? goodsSize;
    int? left;
    int? top;
    int? goodsPrice;

    factory ItemTagListComponent.fromJson(Map<String, dynamic> json) =>
        _$ItemTagListComponentFromJson(json);

    Map<String, dynamic> toJson() => _$ItemTagListComponentToJson(this);
  }

  @JsonSerializable()
  class ItemInfo {
    ItemInfo({
      required this.goodsNo,
      required this.goodsNm,
      required this.brandNm,
      required this.goodsImgUrl,
    });

    String goodsNo;
    String goodsNm;
    String? brandNm;
    String? goodsImgUrl;

    factory ItemInfo.fromJson(Map<String, dynamic> json) =>
        _$ItemInfoFromJson(json);

    Map<String, dynamic> toJson() => _$ItemInfoToJson(this);
  }

  @JsonSerializable()
  class UserInfo {
    final String? memNo;
    final String? memId;
    final String? memNm;
    final String? nickNm;
    final int? gender;
    final String? birthday;
    final String? email;
    final String? phone;
    final String? profileImage;
    final String? introduce;
    final int? heightId;
    final int? weightId;
    final int? bodyShapeId;
    final List<int>? styleIdList;
    final List<int>? colorIdList;
    final int? postCount;
    final int? followerCount;
    final int? followCount;
    bool? isFollow;

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

    factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
    Map<String, dynamic> toJson() => _$UserInfoToJson(this);
  }