// import 'package:ecommerce_app/constants/const.dart';
// import 'package:ecommerce_app/screens/electronics_shopping.dart';
// import 'package:ecommerce_app/screens/men_shopping_page.dart';
// import 'package:ecommerce_app/screens/women_shopping.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class CreateButton extends StatelessWidget {

//   final String title;
//   final Type pageClass;


//   const CreateButton(this.title,this.pageClass, {super.key});
    
// // 
//   @override
//   Widget build(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () {
//       Navigator.push(context,MaterialPageRoute(builder: (context) => _getInstance(pageClass),));
//     },
//     style: ButtonStyle(
//       minimumSize: MaterialStateProperty.all(const Size(40, 70)),
//       backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
//       shape: MaterialStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//     ),
//     child: Text(
//       title,
//       style: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.w700,
//         color: primaryColor,
//       ),
//     ),
//   );
// }

// _getInstance(Type pageClass) {
//   if (pageClass == MenShopping) {
//       return const MenShopping();
//     }
//   else if(pageClass == ElectronicsShopping){
//     return const ElectronicsShopping();
//   }
//   else if(pageClass == WomenShopping){
//     return const WomenShopping();
//   }
//     // Handle other cases or return a default page/widget
//     return Container();
// }

//   }
