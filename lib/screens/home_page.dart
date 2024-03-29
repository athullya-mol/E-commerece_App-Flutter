import 'dart:developer';

import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/category_screen.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/services/api_handlers.dart';
import 'package:ecommerce_app/widgets/drawer.dart';
// ignore: unused_import
import 'package:ecommerce_app/widgets/bottombar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text(
          "E-COMMERCE",
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const DrawerScreen(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Category",
              style: TextStyle(
                  fontSize: 30,
                  color: primaryColor,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: webservice().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    log("length ==${snapshot.data!.length}");
                    return SizedBox(
                      height: 80,
                      //  color: Colors.amber,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            // 13,
                            snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                log("clicked");

                                Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ProductScreen(
                                      //  catid: ,catname: ,
                                      catid: snapshot.data![index].id!,
                                      catname: snapshot.data![index].category!,
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(37, 5, 2, 39),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].category!,
                                    // "Cateogry name",
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Offer Products",
              style: TextStyle(
                  fontSize: 22,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),

            //view products
            Expanded(
              child: FutureBuilder(
                  future: webservice().fetchProducts(),
                  builder: (context, snapshot) {
                    //  log("product length ==" + snapshot.data!.length.toString());
                    if (snapshot.hasData) {
                      return StaggeredGridView.countBuilder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              //  14,
                              snapshot.data!.length,
                          crossAxisCount: 2,
                          itemBuilder: (context, index) {
                            final product = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                log("clicked");
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return detailsPage(
                                        id: product.id!,
                                        name: product.productName!,
                                        image: webservice().imageurl +
                                            product.image!,
                                        price: product.price.toString(),
                                        description: product.description!);
                                  },
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              minHeight: 100, maxHeight: 250),
                                          child: Image(
                                              image: NetworkImage(
                                            webservice().imageurl +
                                                product.image!,
                                          )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                              product.productName ?? 'Unknown Product',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Rs. ${product.price}',
                                                //  "2000",
                                                style: TextStyle(
                                                    color: Colors.red.shade900,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (context) =>
                              const StaggeredTile.fit(1));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),

            //closing
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(context),
    );
  }
}
