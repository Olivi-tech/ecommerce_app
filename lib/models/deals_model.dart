class EcommerceDealsModel {
  String? docId;
  String? imageUrl;
  String? productCode;
  String? title;
  String? description;
  String? category;
  String? duration;
  double? price;
  double? deliveryCharges;
  double? discount;

  EcommerceDealsModel({
    this.docId,
    this.description,
    this.price,
    this.title,
    this.category,
    this.imageUrl,
    this.deliveryCharges,
    this.discount,
    this.productCode,
    this.duration,
  });

  EcommerceDealsModel.fromJson({required Map<String, dynamic> jsonData}) {
    docId = jsonData['doc_id'];
    title = jsonData['title'];
    productCode = jsonData['product_code'];
    imageUrl = jsonData['image_url'];
    description = jsonData['description'];
    price = jsonData['price'];
    discount = jsonData['discount'];
    deliveryCharges = jsonData['delivery_charges'];
    category = jsonData['category'];
    duration = jsonData['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['doc_id'] = docId;
    data['product_code'] = productCode;
    data['image_url'] = imageUrl;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['delivery_charges'] = deliveryCharges;
    data['discount'] = discount;
    data['duration'] = duration;
    return data;
  }
}
