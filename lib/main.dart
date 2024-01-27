import 'dart:developer';

import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/login_page.dart';
import 'package:ecommerce_app/services/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  //runApp(MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    });
    log("isLoggedIn = $isLoggedIn");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue, foregroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn == true ? const HomePage() : const LoginPage(),
    );
  }
}
