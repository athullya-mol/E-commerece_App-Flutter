// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _usernameContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();


@override
  void dispose() {
    _usernameContoller.dispose();
    _passwordContoller.dispose();
    super.dispose();
  }
Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://bootcamp.cyralearnings.com/login.php'),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['msg'] == 'success') {
          saveLoginStatus();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logged in successfully as $username'),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Username or Password is incorrect'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to login. Please try again.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to login. Please try again.'),
        ),
      );
    }
  }


/*......................Displaying on console...................... */
void checkAutoLogin() async{
  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool('loggedIn')?? false;
  // var logger = Logger();
  // logger.i("Logged in value:$loggedIn");
  if(loggedIn){
    //Auto login is possible,navigate to home page
    Navigator.pushReplacement(
      context,
    MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}


void saveLoginStatus() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('loggedIn', true);
}

@override
  void initState(){
  super.initState();
  checkAutoLogin();
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
                key: _formkey,
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
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Please enter your Username';
                        }
                        return null;
                      },
                      controller: _usernameContoller,
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
                      obscureText: true,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      controller: _passwordContoller,
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
                        String username = _usernameContoller.text;
                        String password = _passwordContoller.text;
                        if(_formkey.currentState!.validate()){
                          print(username);
                          print(password);
                          login(username, password);
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp(),));
                        },
                        child: Text('Go to Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo.shade900
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

