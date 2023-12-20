class ProductModel {
  int? id;
  int? catid;
  String? name;
  double? price;
  String? image;
  String? description;

  ProductModel({
    this.id,
    required this.catid,
     required this.name,
    this.price,
    this.image,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        catid: json["catid"],
        name: json["productname"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        description: json["description"],
      );
}