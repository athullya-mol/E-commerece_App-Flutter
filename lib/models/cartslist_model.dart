
class CartProduct {
  int id;
  String image;
  String title;
  double price;
  int qty; 

  CartProduct({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.qty,
  });
   factory CartProduct.fromJson(Map<String, dynamic> json){
    return CartProduct(
        id: json["id"] ?? 0,
        title: json["name"] ?? '',
        price: double.parse(json["price"].toString()),
        image: json["image"] ?? "",
        qty: json["qty"] ?? 1,
      );
   }
      Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'qty': qty,
    };
  }
}


