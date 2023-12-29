class BrandResponse {
  bool success;
  List<BrandData> data;

  BrandResponse({required this.success, required this.data});

  factory BrandResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<BrandData> dataList = list.map((i) => BrandData.fromJson(i)).toList();
    return BrandResponse(success: json['success'], data: dataList);
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BrandData {
  String cateCd;
  String cateNm;
  String brandImgUrl;

  BrandData({required this.cateCd, required this.cateNm, required this.brandImgUrl});

  factory BrandData.fromJson(Map<String, dynamic> json) {
    return BrandData(
      cateCd: json['cateCd'],
      cateNm: json['cateNm'],
      brandImgUrl: json['brandImgUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'cateCd': cateCd,
    'cateNm': cateNm,
    'brandImgUrl': brandImgUrl,
  };
}