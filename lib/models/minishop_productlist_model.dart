import 'product.dart';

class GetMinishopProductListModel {
  GetMinishopProductListModel({
    this.success,
    this.data,
  });

  bool? success;
  List<Product>? data;

  GetMinishopProductListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data!.map((e) => e.toJson()).toList();
    return data;
  }
}
