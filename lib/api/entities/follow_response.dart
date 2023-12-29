import 'package:json_annotation/json_annotation.dart';

part 'follow_response.g.dart';

@JsonSerializable()
class FollowResponse {
  final bool success;
  final List<FollowData> data;

  FollowResponse({
    required this.success,
    required this.data,
  });

  factory FollowResponse.fromJson(Map<String, dynamic> json) =>
      _$FollowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FollowResponseToJson(this);
}

@JsonSerializable()
class FollowData {
  final String followMemNo;
  final bool isFollow;

  FollowData({
    required this.followMemNo,
    required this.isFollow,
  });

  factory FollowData.fromJson(Map<String, dynamic> json) =>
      _$FollowDataFromJson(json);

  Map<String, dynamic> toJson() => _$FollowDataToJson(this);
}
