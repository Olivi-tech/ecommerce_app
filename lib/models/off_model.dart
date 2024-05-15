class OffModel {
  String? docId;
  String? season;
  String? off;

  OffModel({
    this.docId,
    this.season,
    this.off,
  });

  OffModel.fromJson({required Map<String, dynamic> jsonData}) {
    docId = jsonData['doc_id'];

    off = jsonData['product_code'];
    season = jsonData['image_url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['doc_id'] = docId;
    data['off'] = off;
    data['season'] = season;

    return data;
  }
}
