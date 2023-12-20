import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/services/api_handlers.dart';
import 'package:ecommerce_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  String _paymentMethod = ''; 
  final Future<Map<String, dynamic>> _userDetails = Future.value({});
  late String username;

  ApiHandler apiHandler = ApiHandler();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Retrieve the username stored during SignUp
      username = prefs.getString('registeredUsername') ?? '';

      // _userDetails = apiHandler.getUser(username);
      setState(() {});
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Widget buildText(String label, String value) {
  return Row(
    children: [
      Text(label,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 16,

        ),
      ),
      Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(value, 
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            
          ),
          ),
        ),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: primaryColor
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
              fontSize: 26,
              color: primaryColor,
              fontWeight: FontWeight.w800),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: _userDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final userData = snapshot.data ?? {};
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildText('Name:', ('\t${userData['name']}')),
                            const SizedBox(height: 10),
                            buildText('Phone No:', '\t${userData['phone']}'),
                            const SizedBox(height: 10),
                            buildText('Address:', '\t${userData['address']}'),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: const Text('Cash on Delivery',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
                ),
                subtitle: const Text('Pay Cash At Home'),
                leading: Radio(
                  value: 'Cash on Delivery',
                  activeColor: primaryColor,
                  groupValue: _paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value.toString();
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Pay Now',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
                ),
                subtitle: const Text('Online Payment'),
                leading: Radio(
                  value: 'Google Pay',
                  activeColor: primaryColor,
                  groupValue: _paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/2.45,
              ),
              ElevatedButton(
                onPressed: () {
                  
                  if (_paymentMethod == 'Cash on Delivery') {
                   
                  } else if (_paymentMethod == 'Google Pay') {
                    
                  }
                },

                style: ButtonStyle(
                        
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.indigo.shade900),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal:140,vertical: 18)),
                      ),
                child: const Text('Checkout',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomBar(context),
    );
  }
}
