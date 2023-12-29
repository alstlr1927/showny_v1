class MinishopCategoryModel {
  String categoryId = "0";
  String name = "";

  MinishopCategoryModel({this.categoryId = "0", this.name = ""});

  MinishopCategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['name'] = name;
    return data;
  }
}
