class EcommerceProductModel {
  String? id;
  String? imageUrl;
  String? productCode;
  String? title;
  String? description;
  String? category;
  String? reviews;
  double? price;
  double? deliveryCharges;
  double? discount;
  int? soldCount;

  EcommerceProductModel({
    this.id,
    this.description,
    this.price,
    this.title,
    this.category,
    this.soldCount,
    this.imageUrl,
    this.deliveryCharges,
    this.discount,
    this.productCode,
    this.reviews,
  });

  EcommerceProductModel.fromJson({required Map<String, dynamic> jsonData}) {
    id = jsonData['id'];
    title = jsonData['title'];
    productCode = jsonData['product_code'];
    imageUrl = jsonData['image_url'];
    description = jsonData['description'];
    price = jsonData['price'];
    discount = jsonData['discount'];
    deliveryCharges = jsonData['delivery_charges'];
    category = jsonData['category'];
    soldCount = jsonData['sold_count'];
    reviews = jsonData['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_code'] = productCode;
    data['image_url'] = imageUrl;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['sold_count'] = soldCount;
    data['delivery_charges'] = deliveryCharges;
    data['discount'] = discount;
    data['reviews'] = reviews ?? "";
    return data;
  }
}
