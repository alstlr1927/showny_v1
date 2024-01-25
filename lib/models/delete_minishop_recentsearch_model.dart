class DeleteMinishopRecentSearchModel {
  DeleteMinishopRecentSearchModel({
    this.success,
  });
  bool? success;

  DeleteMinishopRecentSearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }
}
