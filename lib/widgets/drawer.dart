import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/cartitems_page.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/login_page.dart';
import 'package:ecommerce_app/screens/order_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: const EdgeInsets.only(left: 15), children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'E-COMMERCE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: primaryColor,
              size: 30,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_cart,
              color: primaryColor,
              size: 30,
            ),
            title: const Text(
              'Cart Page',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartItemScreen(),
                    ));
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.done_all_rounded,
              color: primaryColor,
              size: 30,
            ),
            title: const Text(
              'Orders',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderDetailsPage(),
                    ));
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              color: Colors.red,
              size: 30,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                _logout(context);
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ),
        ]),
      );
  }
}

void _logout(BuildContext context) async {
  final currentContext = context;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('loggedIn', false);
  Future.delayed(
    Duration.zero,
    () {
      Navigator.pushReplacement(
          currentContext,
          MaterialPageRoute(
            builder: (context) => const LoginPage()
          )
      );
    },
  );
}
