// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/signup_page.dart';
import 'package:ecommerce_app/services/api_handlers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
String? username, password;
  final  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


 
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log("isloggedin = $isLoggedIn");
    if (isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }
login(String username, String password) async {
    try {
      print('webservice');
      print(username);
      print(password);
      var result;
      final Map<String, dynamic> loginData = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse("${webservice.mainurl}login.php"),
        body: loginData,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("login successfully completed");
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("username", username);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ));
        } else {
          log("login failed");
          result = {log(json.decode(response.body)['error'].toString())};
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text( "Invalid username or password!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
        }
      }
      else {
        result = {log(jsonDecode(response.body)['error'].toString())};
      }
      return result;
    } catch (e) {
      log(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200, left: 15, right: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Welcome Back',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
                    ),
                    const Text('Login with your username and password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    TextFormField(
                      cursorColor: primaryColor,
                      controller: usernameController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Please enter your Username';
                        }
                        return null;
                      },
                      onChanged: (value){
                        setState(() {
                          username = value;
                        });
                      } ,
                      style: const TextStyle(
                        fontSize: 21
                      ),
                      decoration: InputDecoration(

                        fillColor: Colors.grey.shade200,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 18),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        
                        labelText: 'Username',
                        labelStyle: const TextStyle(
                          fontSize: 20,
                        ),
        
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                     onChanged: (value) {
                       setState(() {
                         password=value;
                       });
                     },
                      style: const TextStyle(
                        fontSize: 21
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 18),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontSize: 20,
                        ),
                        
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    ElevatedButton(
                      onPressed: () {
                       if (_formKey.currentState!.validate()) {
                        username = usernameController.text;
                        password = passwordController.text;

                        log("username = $username");
                        log("password = $password");
                        login(username.toString(), password.toString());
                      }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        minimumSize: const Size(200, 55)
                      ),
                      child: const Text('Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      )
                      ),
                      const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                        },
                        child: const Text('Go to Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                        ),
                        
                      ),
                      ],
                    )
                  ],
                  ),
              ),
            ),
          ),
        )),
    );
  }
}

