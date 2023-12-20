import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:flutter/material.dart';

int currentIndex = 0;

Future<void> navigateToPage(BuildContext context, int index) async {
  // if (index == 0) {
  //   Navigator.push(
  //       // context, MaterialPageRoute(builder: (context) => const MenShopping()));
  // }
  if (index == 1) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
  if (index == 2) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  } else {
    currentIndex = index;
  }
}

BottomNavigationBar bottomBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      navigateToPage(context, index);
    },
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.black,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.arrow_forward_ios,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.arrow_back_ios_new_sharp),
        label: '',
      ),
    ],
  );
}
