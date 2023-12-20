import 'dart:convert';
import 'package:ecommerce_app/models/cartslist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<List<CartProduct>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = prefs.getString('cartItems');
    if (cartItemsJson != null && cartItemsJson.isNotEmpty) {
      final decodedCartItems = jsonDecode(cartItemsJson) as List<dynamic>;
      return decodedCartItems.map((item) => CartProduct.fromJson(item)).toList();
    }
    return [];
  }

  static Future<void> saveCartItems(List<CartProduct> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartListJson = cartItems.map((item) => item.toJson()).toList();
    await prefs.setString('cartItems', jsonEncode(cartListJson));
  }
}