// ignore_for_file: file_names

class ProductModel {
  int? id;
  int? catid;
  double? price;
  String? productName;
  String? description;
  String? image;

  ProductModel({
    this.id,
    this.catid,
    this.price,
    this.productName,
    this.description,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      catid: json['catid'],
      price: json['price']?.toDouble(),
      productName: json['productname'],
      description: json['description'],
      image: json['image']);
}
