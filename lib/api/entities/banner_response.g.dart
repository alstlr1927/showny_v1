// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => BannerData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BannerResponseToJson(BannerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

BannerData _$BannerDataFromJson(Map<String, dynamic> json) => BannerData(
      bannerNo: json['bannerNo'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      bannerImg: json['bannerImg'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$BannerDataToJson(BannerData instance) =>
    <String, dynamic>{
      'bannerNo': instance.bannerNo,
      'type': instance.type,
      'title': instance.title,
      'bannerImg': instance.bannerImg,
      'createdAt': instance.createdAt,
    };
