import 'package:json_annotation/json_annotation.dart';
import 'package:showny/api/entities/style_up_response.dart';

part 'post_data_response.g.dart';

@JsonSerializable()
class PostDataResponse {
  PostDataResponse({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<STUData> data;

  factory PostDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PostDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataResponseToJson(this);
}
