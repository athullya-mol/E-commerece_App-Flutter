import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/login_page.dart';
import 'package:ecommerce_app/services/api_handlers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? name, phone, address, username, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // bool processing = false;
  registration(String name, phone, address, username, password) async {
    try {
      print(username);
      print(password);
      var result;
      // ignore: non_constant_identifier_names
      final Map<String, dynamic> Data = {
        'name': name,
        'phone': phone,
        'address': address,
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse("${webservice.mainurl}registration.php"
            // Webservice.mainurl + "registration.jsp"
            ),
        body: Data,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("Registration successfully completed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("Registration successfully completed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const LoginPage();
            },
          ));
        } else {
          log("Registration failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("Registration Failed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
        }
      } else {
        result = {log(json.decode(response.body)['error'].toString())};
      }
      return result;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Register Account",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Complete your details  \n",
            ),
            const SizedBox(height: 28),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Name ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                phone = text;
                              });
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter phone ";
                              } else if (value.length > 10 ||
                                  value.length < 10) {
                                return "Please enter valid phone number ";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Phone',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Center(
                          child: TextFormField(
                            maxLines: 4,
                            onChanged: (text) {
                              setState(() {
                                address = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Address',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                username = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Username',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your username';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your password ';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // processing == true
                  //     ? const Center(
                  //         child: CircularProgressIndicator(
                  //         color: Color.fromARGB(255, 5, 1, 50),
                  //       ))
                  //     :
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log("name = $name");
                            log("phone = $phone");
                            log("address = $address");
                            log("username = $username");
                            log("password = $password");
                            registration(
                                name!, phone, address, username, password);
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Do you have an account? ",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        // Color.fromARGB(255, 5, 1, 50),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
