import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/models/cartslist_model.dart';
import 'package:ecommerce_app/services/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
@override
Widget buildCartItem(BuildContext context,CartProduct cartItem, int index, CartProvider cartProvider) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
    return Dismissible(
       key: UniqueKey(), // Use UniqueKey for each Dismissible to maintain uniqueness
    direction: DismissDirection.endToStart,
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      color: primaryColor,
      child: const Icon(Icons.delete,
      size: 25,
      color: Colors.white
      ),
    ),
    onDismissed: (direction) {
      // Remove the item when dismissed
      cartProvider.removeFromCart(cartItem.id);
      // cartProvider.removeFromCart(cartItem.id).then((value) {
        // cartProvider.fetchCartItems();
      // });
    },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  cartItem.image,
                  height: 120,
                  width: 150,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.title,
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      cartItem.price.toString(),
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Container(
                padding: const EdgeInsets.all(5),
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => cartProvider.increment(index),
                      icon: const Icon(
                        CupertinoIcons.plus,
                        color: Colors.white,
                        size: 20,
                      ),
                      alignment: Alignment.center,
                    ),
                    Text(
                      '${cartProvider.productQuantities[index] ?? 1}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () => cartProvider.decrement(index),
                      icon: const Icon(
                        CupertinoIcons.minus,
                        color: Colors.white,
                        size: 20,
                      ),
                      alignment: AlignmentDirectional.center,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    });
}