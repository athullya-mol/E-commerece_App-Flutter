
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  final List<CartProducts> _list = [];

  List<CartProducts> get getItems {
    return _list;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      total = total + (item.price * item.qty);
    }
    return total;
  }

  int? get count {
    return _list.length;
  }

  void addItem(int id, String name, double price, int qty, String imagesUrl) {
    final product = CartProducts(
        id: id, name: name, price: price, qty: qty, imagesUrl: imagesUrl);

    _list.add(product);
    notifyListeners();
    log("add Product");
  }

  void increment(CartProducts product) {
    product.increase();
    notifyListeners();
  }

  void decrement(CartProducts product) {
    product.decrease();
    notifyListeners();
  }

  void reduceByOne(CartProducts product) {
    product.decrease();
    notifyListeners();
  }

  void removeAt(CartProducts product) {
    _list.remove(product);
    notifyListeners();
  }

  void ClearCart() {
    _list.clear();
    notifyListeners();
  }
}

class CartProducts {
  int id;
  String name;
  double price;
  int qty = 1;
  String imagesUrl;

  CartProducts(
      {required this.id,
      required this.name,
      required this.price,
      required this.imagesUrl,
      required this.qty});

  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }

  factory CartProducts.fromJson(Map<String, dynamic> json) => CartProducts(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      imagesUrl: json["image"],
      qty: json["qty"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "price": price, "image": imagesUrl, "qty": qty};
}
