class BannerModel {
  String bannerNo;
  String type;
  String title;
  String bannerImg;
  String linkUrl;
  String createdAt;

  BannerModel({
    this.bannerNo = "",
    this.type = "",
    this.title = "",
    this.bannerImg = "",
    this.linkUrl = "",
    this.createdAt = ""
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerNo: json['bannerNo'] as String? ?? "",
      type: json['type'] as String? ?? "",
      title: json['type'] as String? ?? "",
      bannerImg: json['bannerImg'] as String? ?? "",
      linkUrl: json['linkUrl'] as String? ?? "",
      createdAt: json['created_at'] as String? ?? ""
    );
  }
}