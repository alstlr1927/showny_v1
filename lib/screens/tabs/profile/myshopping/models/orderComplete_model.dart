class OrderCompleteModel {
  int? id;
  String? imageUrl;
  String? title;
  String? brandName;
  String? color;
  String? productAmount;
  String? deliveryFee;
  String? paymentAmount;
  String? discountAmount;
  String? totalAmount;

  OrderCompleteModel(
      {this.id,
      this.imageUrl,
      this.title,
      this.brandName,
      this.color,
      this.productAmount,
      this.discountAmount,
      this.paymentAmount,
      this.totalAmount,
      this.deliveryFee});

  factory OrderCompleteModel.fromJson(Map<String, dynamic> json) {
    return OrderCompleteModel(
        id: json['id'],
        imageUrl: json['image_url'],
        title: json['title'],
        brandName: json['brand_name'],
        productAmount: json['product_amount'],
        deliveryFee: json['delivery_fee'],
        paymentAmount: json['payment_amount'],
        discountAmount: json['discount_amount'],
        totalAmount: json['total_amount'],
        color: json['color']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'title': title,
      'brand_name': brandName,
      'color': color,
      'delivery_fee': deliveryFee,
      'payment_amount': paymentAmount,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'product_amount': productAmount,
    };
  }
}
