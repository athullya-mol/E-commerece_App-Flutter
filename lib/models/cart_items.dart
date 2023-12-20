import 'package:flutter/material.dart';

class CartProduct {
  int id;
  String image;
  String title;
  String price;
  final int qty; 

  CartProduct({
    required this. id,
    required this.image,
    required this.title,
    required this.price,
    required this.qty,
  });
  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["id"],
        title: json["name"],
        price: json["price"],
        image: json["image"],
        qty: json["qty"],
      );
}

class CartItems {
  static List<CartProduct> cartProducts = [];

  static void addToCart(CartProduct product) {
    cartProducts.add(product);
  }
}

void addToCart(BuildContext context,int id, String title, String imgurl, String price) {
  if (!CartItems.cartProducts.any((product) => product.title == title)) {
    CartItems.addToCart(
      CartProduct(
        id: id,
        image: imgurl,
        title: title,
        price: price,
        qty: 1, 
      ),
    );
  }
}
