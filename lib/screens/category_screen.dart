import 'dart:developer';

import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/services/api_handlers.dart';
import 'package:ecommerce_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductScreen extends StatefulWidget {
  final String catname;
  final int catid;

  const ProductScreen({required this.catid, required this.catname, Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    log("catname = ${widget.catname}");
    log("catid = ${widget.catid}");
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.catname,
          // "Category name",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
          future: ApiHandler().getCategoryProducts(widget.catid),
          builder: (context, snapshot) {
            // log("length ==" + snapshot.data!.length.toString());
            if (snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        log("clicked");
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsScreen(
                              id: product.id!,
                              name: product.name!,
                              image: ApiHandler().imageurl + product.image!,
                              price: product.price.toString(),
                              description: product.description!,
                            );
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
                                    ApiHandler().imageurl + product.image!,
                                  )
                                      //  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGUU3VWK2nTbvZRiUCORkJJ80S4JrCoCqoYQ&usqp=CAU"),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        product.name!,

                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Rs. ',
                                              style: TextStyle(
                                                  color: Colors.red.shade900,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              //  "2000",
                                              product.price.toString(),

                                              style: TextStyle(
                                                  color: Colors.red.shade900,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
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
          bottomNavigationBar: bottomBar(context),
    );
  }
}