
// import 'package:ecommerce_app/models/product_items.dart';
// import 'package:ecommerce_app/screens/product_details_page.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class ProductCard extends StatelessWidget { 
//  final Product baseProduct;
// const ProductCard({required this.baseProduct, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//                       borderRadius: BorderRadius.circular(40),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails.fromBasicDetails(baseProduct.image, baseProduct.title, baseProduct.price),));
//                         },
//                         style: ButtonStyle(
//                           backgroundColor:const MaterialStatePropertyAll(Colors.white),
//                           elevation: MaterialStateProperty.all(0),
//                           padding: MaterialStateProperty.all(
//                             const EdgeInsets.all(5),
//                           ),
//                         ),

//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Image.asset('assets/images/${baseProduct.image}.png',
//                                   height: 150,
//                                   alignment: Alignment.topCenter,  
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(10),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         // Replace this with product name
//                                         baseProduct.title,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                           color: Colors.grey.shade900,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         // Replace this with product price
//                                         baseProduct.price,
//                                         style: TextStyle(
//                                           color: Colors.red.shade900,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
                
//                         );
 
//   }}
