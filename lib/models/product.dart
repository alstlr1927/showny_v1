class Product {
  Product({
    this.id,
    this.memNo,
    this.name,
    this.categoryId,
    this.isHeart,
    this.price,
    this.deliveryPrice,
    this.viewSize,
    this.isNew,
    this.description,
    this.brand,
    this.brandImageUrl,
    this.actualSize,
    this.colorIdList,
    this.productImageUrlList,
    this.wearImageUrlList,
    this.status,
    this.createdAt,
  });
  String? id;
  String? memNo;
  String? name;
  int? categoryId;
  bool? isHeart;
  int? price;
  int? deliveryPrice;
  String? viewSize;
  bool? isNew;
  String? description;
  String? brand;
  String? brandImageUrl;
  String? actualSize;
  String? colorIdList;
  List<String>? productImageUrlList;
  List<String>? wearImageUrlList;
  int? status;
  String? createdAt;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memNo = json['memNo'];
    name = json['name'];
    categoryId = json['categoryId'];
    isHeart = json['isHeart'];
    price = json['price'];
    deliveryPrice = json['deliveryPrice'];
    viewSize = json['viewSize'];
    isNew = json['isNew'];
    description = json['description'];
    brand = json['brand'];
    brandImageUrl = json['brandImageUrl'];
    actualSize = json['actualSize'];
    colorIdList = json['colorIdList'];
    productImageUrlList =
        List.castFrom<dynamic, String>(json['productImageUrlList']);
    wearImageUrlList = List.castFrom<dynamic, String>(json['wearImageUrlList']);
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['memNo'] = memNo;
    data['name'] = name;
    data['categoryId'] = categoryId;
    data['isHeart'] = isHeart;
    data['price'] = price;
    data['deliveryPrice'] = deliveryPrice;
    data['viewSize'] = viewSize;
    data['isNew'] = isNew;
    data['description'] = description;
    data['brand'] = brand;
    data['brandImageUrl'] = brandImageUrl;
    data['actualSize'] = actualSize;
    data['colorIdList'] = colorIdList;
    data['productImageUrlList'] = productImageUrlList;
    data['wearImageUrlList'] = wearImageUrlList;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
