
// import 'package:ecommerce_app/constants/const.dart';
// import 'package:ecommerce_app/screens/checkout_page.dart';
// import 'package:ecommerce_app/services/provider/cart_provider.dart';
// import 'package:ecommerce_app/widgets/bottom_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// // ignore: must_be_immutable
// class CartItemScreen extends StatelessWidget {
  
//   const CartItemScreen({super.key});

// //    List<CartProduct> cartList = [];
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     return Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.grey.shade100,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios_new,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             "Cart",
//             style: TextStyle(
//               fontSize: 25,
//               color: Colors.black,
//             ),
//           ),
//           actions: [
//             Consumer<CartProvider>(
//             builder: (context, cartProvider, child) {
//               return IconButton(
//                 onPressed: () {
//                   if (cartProvider.cartList.isNotEmpty) {
//                     cartProvider.removeFromCart(0);
//                   }
//                 },
//                 icon: const Icon(Icons.delete),
//                 color: primaryColor,
//                 iconSize: 26,
//               );
//             },
//           ),
//           ],
//         ),
//          body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Center(
//             child: cartProvider.cartList.isEmpty
//             ? Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height/1.4,
//                   child: Image.asset('assets/images/empty.png',
//                   fit: BoxFit.contain,
//                   ),
//                 ),
//                 const Text(
//           'Your Cart Is Empty!',
//           style: TextStyle(
//               fontSize: 26,
//               color: primaryColor,
//               fontWeight: FontWeight.w800,
//               letterSpacing: 2.5,
//               ),
//                 )
//               ],
//             )
//            : Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//               for (int i = 0; i < cartProvider.cartList.length; i++)
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     height: 120,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Image.network(
//                             cartProvider.cartList[i].image,
//                             height: 120,
//                             width: 150,
//                           ),
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width / 4,
//                           padding: const EdgeInsets.only(top: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                               cartProvider.cartList[i].title,
//                                 style: const TextStyle(
//                                   color: primaryColor,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 cartProvider.cartList[i].price.toString(),
//                                 style: TextStyle(
//                                   color: Colors.red.shade900,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           height: 40,
//                           width: 120,
//                           decoration: BoxDecoration(
//                             color: primaryColor,
//                             borderRadius: BorderRadius.circular(40),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 onPressed: () => cartProvider.increment(i),
//                                 icon: const Icon(
//                                   CupertinoIcons.plus,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                                 alignment: Alignment.center,
//                               ),
//                               Text(
//                                 '${cartProvider.productQuantities[i] ?? 1}',
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () => cartProvider.decrement(i),
//                                 icon: const Icon(
//                                   CupertinoIcons.minus,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                                 alignment: AlignmentDirectional.center,
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                 height: MediaQuery.of(context).size.height/2.35,
//              ),
//                   Container(
//                   height: 80,
//                   width: MediaQuery.of(context).size.width,
//                   color: Colors.grey.shade200,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical:5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                             'Total : ${cartProvider.calculateTotalPrice(cartProvider.cartList, cartProvider.productQuantities)}',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.red.shade800,
//                             ),
//                             ),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPage()));
//                         }, 
//                         style: ButtonStyle(
                          
//                           backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
//                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                           padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal:24,vertical: 18)),
//                         ),
//                         child: const Text("Order Now",
//                         style: TextStyle(
//                           fontSize: 24,
//                         ),
//                         ), ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//         bottomNavigationBar: bottomBar(context),
//         );
//   }

// //   String calculateTotalPrice(List<CartProduct> cartList,Map<int, int> productQuantities) {
// //     double totalPrice = 0;
// //     for (int i = 0; i < cartList.length; i++) {
// //       String price = cartList[i].price.toString().substring(3).replaceAll(',', '');
// //       int itemPrice = int.tryParse(price) ?? 0;
// //       int quantity = productQuantities[i] ?? 1;
// //       totalPrice += itemPrice * quantity;
// //     }
// //     return 'Rs.${totalPrice.toStringAsFixed(2)}';
// //   }
//  }