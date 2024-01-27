// ignore_for_file: file_names

import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/checkout_page.dart';
import 'package:ecommerce_app/services/provider/cart_provider.dart';
import 'package:ecommerce_app/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartPage extends StatelessWidget {
  List<CartProducts> cartlist = [];

  CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: primaryColor,
              )),
          title: const Text(
            "Cart",
            style: TextStyle(fontSize: 25, color: primaryColor),
          ),
          actions: [
            context.watch<Cart>().getItems.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      context.read<Cart>().ClearCart();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: primaryColor,
                    ),
                  )
          ],
        ),
        body: context.watch<Cart>().getItems.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: Image.asset(
                      'assets/images/empty.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'Your Cart Is Empty!',
                    style: TextStyle(
                      fontSize: 26,
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ))
            : Consumer<Cart>(
                builder: (context, cart, child) {
                  cartlist = cart.getItems;
                  return ListView.builder(
                      itemCount: cart.count,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key:
                              UniqueKey(), // Use UniqueKey for each Dismissible to maintain uniqueness
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            color: primaryColor,
                            child: const Icon(Icons.delete,
                                size: 25, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            // Remove the item when dismissed
                            cart.removeAt(cartlist[index]);
                            // cartProvider.removeFromCart(cartItem.id).then((value) {
                            // cartProvider.fetchCartItems();
                            // });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      width: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 9),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      cartlist[index]
                                                          .imagesUrl,),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                        child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Wrap(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              cartlist[index].name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  cartlist[index]
                                                      .price
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.red.shade900),
                                                ),
                                                Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          if (cartlist[index]
                                                                  .qty >
                                                              1) {
                                                            cart.reduceByOne(
                                                                cartlist[
                                                                    index]);
                                                          } else {
                                                            cart.removeAt(
                                                                cart.getItems[
                                                                    index]);
                                                          }
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .minimize_rounded,
                                                          size: 18,
                                                          color: Colors.white,
                                                        )),
                                                    Text(
                                                      cartlist[index]
                                                          .qty
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          cart.increment(
                                                              cartlist[index]);
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 18,
                                                          color: Colors.white,
                                                        ))
                                                  ]),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
        bottomSheet: context.watch<Cart>().getItems.isNotEmpty
            ? Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total : ${context.watch<Cart>().totalPrice}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                          onTap: () {
                         Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return CheckoutPage(cart: cartlist);
                                    },
                                  ));
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: primaryColor),
                            child: const Center(
                              child: Text(
                                "Order Now!",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
            )
            : const Text(''),
            bottomNavigationBar: bottomBar(context),
            );
  }
}
