import 'package:json_annotation/json_annotation.dart';

part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  final bool success;
  final List<BannerData> data;

  BannerResponse({
    required this.success,
    required this.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class BannerData {
  late final String? bannerNo;
  late final String? type;
  late final String? title;
  late final String? bannerImg;
  late final String? createdAt;

  BannerData({
    required this.bannerNo,
    required this.type,
    required this.title,
    required this.bannerImg,
    required this.createdAt,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) =>
      _$BannerDataFromJson(json);

  Map<String, dynamic> toJson() => _$BannerDataToJson(this);
}
