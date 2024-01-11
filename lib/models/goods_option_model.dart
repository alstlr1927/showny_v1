class GoodsOptionModel {
  String name = "";
  List<String> value = [];

  GoodsOptionModel({this.name = "", this.value = const []});

  GoodsOptionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String? ?? "";
    var temp = json['value'] as List<dynamic>? ?? [];
    for (var item in temp) {
      value.add(item.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }

  GoodsOptionModel.clone(GoodsOptionModel source)
      : name = source.name,
        value = List<String>.from(source.value);
}
