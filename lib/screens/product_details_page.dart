
// import 'package:ecommerce_app/constants/const.dart';
// import 'package:ecommerce_app/models/cart_items.dart';
// import 'package:ecommerce_app/models/product_descriptions.dart';
// import 'package:ecommerce_app/screens/cart_page.dart';
// import 'package:ecommerce_app/screens/home_page.dart';
// import 'package:ecommerce_app/widgets/bottom_bar.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class ProductDetails extends StatelessWidget {
//   final String imgurl;
//   final String title;
//   final String price;
//   final Description? description;
//   const ProductDetails.fromBasicDetails(this.imgurl,this.title,this.price,{Key? key})
//    : description=null,
//   super(key: key);
//   const ProductDetails(this.imgurl,this.title,this.price,this.description,{super.key});
 
//  Description? findDescription(String title) {
//     return ProductDescriptions().descriptions.firstWhere(
//       (element) => element.title == title,
//       orElse: () => Description(title: '', description: ''),
//     );
//   }

// void addToCart(BuildContext context) {
//   if (!CartItems.cartProducts.any((product) => product.title == title)) {
//     CartItems.addToCart(CartProduct(
//       image: imgurl,
//       title: title,
//       price: price,
//       quantity: 1, 
//     ));
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     final Description? currentDescription = findDescription(title);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//                  onPressed: () {
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
//                  }, 
//                  icon: const Icon(Icons.arrow_back_ios),
//                  color: primaryColor,
//                  ),
//       ),
//        backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 270,
//                     width: MediaQuery.of(context).size.width,
//                     child: Image.asset('assets/images/$imgurl.png',
//                     fit: BoxFit.contain,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Stack(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(title,
//                                 style: const TextStyle(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.bold,
//                                   color: primaryColor,
//                                 ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(price,
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.red.shade900,
//                                 ),
//                                 ),
//                                 const SizedBox(
//                                   height: 25,
//                                 ),
//                                 if(currentDescription != null)
//                                 Text(currentDescription.description,
//                                 textAlign: TextAlign.justify,
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500,
//                                   height: 1.4,
//                                 ),
//                                 ),
                                
//                               ],
//                             ),
//                           ),
      
                          
//                         ],
//                       ),
//                     ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       addToCart(context); 
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(
//           cartProducts: [
//             ProductDetails(imgurl, title, price,null)])));
//                     }, 
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal:100,vertical: 10)),
//                     ),
//                     child: const Text("Add To Cart",
//                     style: TextStyle(
//                       fontSize: 24,
//                     ),
//                     ), ),
//                 ],
//               ),
//               ),
//         ),
//       ),
//       bottomNavigationBar: bottomBar(context),
//     );
//   }
// }
 