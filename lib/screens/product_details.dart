// ignore_for_file: file_names, camel_case_types

import 'dart:developer';
import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/services/provider/cart_provider.dart';
import 'package:ecommerce_app/widgets/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// ignore: must_be_immutable
class detailsPage extends StatelessWidget {
  String name, price, image, description;
  int id;
  detailsPage({
    super.key,
    required this.name,
    required this.image,
    required this.id,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    log("id = $id");
    log("name = $name");
    log("price = $price");
    log("description = $description");
    log("image =$image");

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
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          }));
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        )),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 225, 229, 229),
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
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        name,
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "RS $price",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.red.shade800,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      description,
                      textScaleFactor: 1.1,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            log("price == ${double.parse(price)}");

            var existingItemCart = context
                .read<Cart>()
                .getItems
                .firstWhereOrNull((element) => element.id == id);
            if (existingItemCart != null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                content: Text(
                  "This item is already in cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ));
            } else {
              context
                  .read<Cart>()
                  .addItem(id, name, double.parse(price), 1, image);

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  content: Text(
                    "Added to Cart",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )));
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: primaryColor),
            child: const Center(
                child: Text(
              "Add to Cart",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
        ),
      ),
      bottomNavigationBar: bottomBar(context),
    ));
  }
}
