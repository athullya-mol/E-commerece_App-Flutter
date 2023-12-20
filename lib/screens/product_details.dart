// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/services/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
 String name, price, image, description;
  int id;
  ProductDetailsScreen(
      {super.key, 
      required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.description});
      

      Future<bool> checkIfItemExistsInCart(int itemId) async {
  final prefs = await SharedPreferences.getInstance();
  final cartItems = prefs.getString('cartItems');
  
  if (cartItems != null && cartItems.isNotEmpty) {
    List<dynamic> decodedCartItems = jsonDecode(cartItems);
    
    return decodedCartItems.any((item) => item['id'] == itemId);
  }
  
  return false;
}
Future<void> addItemToCart(BuildContext context,int id, String name, double price, int quantity, String image) async {
  final prefs = await SharedPreferences.getInstance();
  final cartItemslist = jsonDecode(prefs.getString('cartItems') ?? '[]') as List<dynamic>;

  // Check if the item already exists in cart
  bool itemExists = cartItemslist.any((item) => item['id'] == id);

  if (!itemExists) {
    cartItemslist.add({
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
    });

    await prefs.setString('cartItems', jsonEncode(cartItemslist));
    print('Added item to cart - ID: $id, Name: $name, Price: $price, Quantity: $quantity, Image: $image');
    Provider.of<CartProvider>(context, listen:false).fetchCartItems();
  } else {
    print('Item with ID: $id already exists in the cart.');
  }
}

Future<void> removeFromCart(BuildContext context,int productId) async {
  final prefs = await SharedPreferences.getInstance();
  final cartItemslist = jsonDecode(prefs.getString('cartItems') ?? '[]') as List<dynamic>;

  final index = cartItemslist.indexWhere((item) => item['id'] == productId);
  if (index != -1) {
    cartItemslist.removeAt(index);

    await prefs.setString('cartItems', jsonEncode(cartItemslist));
    print('Removed item from cart - ID: $productId');

    // Fetch updated cart items after removing an item
    Provider.of<CartProvider>(context, listen: false).fetchCartItems();
  }
}

  @override
  Widget build(BuildContext context) {
    log("id = $id");
    log("name = $name");
    log("price = $price");
    log("desc = $description");
    log("image = $image");
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.8,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Image(
                          image: NetworkImage(
                            image,
                          ),
                          // "https://www.jiomart.com/images/product/500x630/rvbeuybald/asian-men-s-sports-running-shoes-for-men-product-images-rvbeuybald-0-202305051152.jpg"),
                        ),
                      ),
                      Positioned(
                          left: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const HomePage();
                                  },
                                ));
                              },
                            ),
                          )),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: (20)),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 239, 240, 241),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 2, 20, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              name,
                              // "Shoes",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Rs.  $price',
                            // "2000",
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            description,
                            // 'A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function but over time shoes also became fashion items.A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function but over time shoes also became fashion items.A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function but over time shoes also became fashion items.A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function but over time shoes also became fashion items.',
                            textScaleFactor: 1.1,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  log("price ==${double.parse(price)}");
                  bool itemExistInCart = await checkIfItemExistsInCart(id);
                  // log("existingItemCart----" + existingItemCart.toString());
                  if (itemExistInCart){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: Text("This item already in cart",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ));
                  } else {
                    await addItemToCart(context,id,name,double.parse(price),1,image);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: Text("Added to cart.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ));
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor),
                  child: const Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )));
  }
}
