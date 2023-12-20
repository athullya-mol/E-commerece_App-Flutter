import 'package:ecommerce_app/models/cartslist_model.dart';
import 'package:ecommerce_app/services/shared_preferences.dart';
import 'package:flutter/material.dart';
// Import your CartProduct model

class CartProvider extends ChangeNotifier {
  List<CartProduct> cartList = [];
  final Map<int, int> _productQuantities = {};

  List<CartProduct> get cartItems => cartList;
  Map<int, int> get productQuantities => _productQuantities;


Future<void> fetchCartItems() async {
    try {
      final cartItems = await SharedPreferencesService.getCartItems();

      cartList.clear();
      _productQuantities.clear();

      for (var item in cartItems) {
        cartList.add(item);
        _productQuantities[item.id] = item.qty;
      }

      notifyListeners();
    } catch (e) {
      print('Error Fetching Cart items: $e');
    }
  }
  
Future<void> saveCart() async {
    await SharedPreferencesService.saveCartItems(cartList);
    notifyListeners();
  }


Future<void> clearCart() async {
    cartList.clear();
    clearProductQuantities();
    await SharedPreferencesService.saveCartItems(cartList);
    notifyListeners();
  }

void clearProductQuantities() {
    _productQuantities.clear();
    notifyListeners();
  }

void setProductQuantity(int index, int quantity) {
    if (_isValidIndex(index)) {
      _productQuantities[index] = quantity;
      notifyListeners();
    }
  }


  void addToCart(CartProduct product) {
    cartList.add(product);
   if (productQuantities.containsKey(product.id)) {
      productQuantities[product.id] = productQuantities[product.id]! + 1;
    } else {
      productQuantities[product.id] = 1;
    }
    notifyListeners();
  }
  

  Future<void> removeFromCart(int productId) async {
     final index = cartList.indexWhere((item) => item.id == productId);
    if (index != -1) {
    final removedItem = cartList.removeAt(index);
    _productQuantities.remove(productId);
    await SharedPreferencesService.saveCartItems(cartList);
    notifyListeners();
    removeFromProductQuantities(removedItem.id);
  }
  }

  void removeFromProductQuantities(int productId) {
  if (_productQuantities.containsKey(productId)) {
    if (_productQuantities[productId]! > 1) {
      _productQuantities[productId] = _productQuantities[productId]! - 1;
    } else {
      _productQuantities.remove(productId);
    }
    notifyListeners();
  }
}

bool _isValidIndex(int index) {
    return _productQuantities.containsKey(index);
  }
void increment(int index) {
  if (_productQuantities.containsKey(index)) {
    final currentValue = _productQuantities[index] ?? 1;
    print('Current value before increment: $currentValue');

    if (currentValue < 9) {
      _productQuantities[index] = currentValue + 1;
      print('Incremented value: ${_productQuantities[index]}');
      notifyListeners();
    }
  } else {
    print('Index $index not found in _productQuantities');
  }
}

void decrement(int index) {
  if (_productQuantities.containsKey(index)) {
    final currentValue = _productQuantities[index] ?? 1;
    print('Current value before decrement: $currentValue');

    if (currentValue > 1) {
      _productQuantities[index] = currentValue - 1;
      print('Decremented value: ${_productQuantities[index]}');
      notifyListeners();
    }
  } else {
    print('Index $index not found in _productQuantities');
  }
}



 String calculateTotalPrice( List<CartProduct> cartList,Map<int, int> productQuantities) {
    double totalPrice = 0;
    for (int i = 0; i < cartList.length; i++) {
      double itemPrice = cartList[i].price;
      int quantity = productQuantities[cartList[i].id] ?? 1;
      totalPrice += itemPrice * quantity;
    }
    return 'Rs.${totalPrice.toStringAsFixed(2)}';
  }
}
