import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/cartitems_page.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/login_page.dart';
import 'package:ecommerce_app/screens/order_page.dart';
import 'package:ecommerce_app/services/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:badges/badges.dart' as badges;
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
            leading: badges.Badge(
              showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
              badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
              badgeContent: Text(
                context.watch<Cart>().getItems.length.toString(),
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
             child: Icon(
              Icons.shopping_cart,
              color: primaryColor,
              size: 30,
            ),
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
                      builder: (context) => CartPage(),
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
                      builder: (context) => const OrderdetailsPage()
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
              onPressed: 
               () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
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
