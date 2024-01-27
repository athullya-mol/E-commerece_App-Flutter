// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/models/user_datamodel.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/services/api_handlers.dart';
import 'package:ecommerce_app/services/provider/cart_provider.dart';
import 'package:ecommerce_app/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CheckoutPage extends StatefulWidget {
  List<CartProducts> cart;
  CheckoutPage({super.key, required this.cart});

  @override
  State<StatefulWidget> createState() => _checkoutPageState();
}

class _checkoutPageState extends State<CheckoutPage> {
  int selectedValue = 1;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  String? username;

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });
    log("isLoggedin = $username");
  }

  orderPlace(
    List<CartProducts> cart,
    String amount,
    String paymentmethod,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    try {
      String jsondata = jsonEncode(cart);
      log('jsondata = $jsondata');

      final vm = Provider.of<Cart>(context, listen: false);

      final response =
          await http.post(Uri.parse("${webservice.mainurl}order.php"), body: {
        "username": username,
        "amount": amount,
        "paymentmethod": paymentmethod,
        "date": date,
        "quantity": vm.count.toString(),
        "cart": jsondata,
        "name": name,
        "address": address,
        "phone": phone
      });

      if (response.statusCode == 200) {
        // log(response.body);
        if (response.body.contains("Success")) {
          vm.ClearCart();

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            padding: EdgeInsets.all(15.0),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text(
              "Your order is successfully completed!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  String? name, address, phone;
  String? paymentmethod = "cash on delivery";


Widget buildText(String label, String value) {
  return Text.rich(
            TextSpan(
              text: '$label :\t',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: primaryColor
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              )
            )
          ]
          ));
}
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primaryColor,
          ),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(fontSize: 25, color: primaryColor),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: FutureBuilder<UserDataModel?>(
                future: webservice().fetchUser(username.toString()),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    name = snapshot.data!.name;
                    phone = snapshot.data!.phone;
                    address = snapshot.data!.address;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.14,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            buildText('Name', name!),
                            const SizedBox(
                              height: 10,
                            ),
                            buildText('Phone', phone!),
                            const SizedBox(
                              height: 10,
                            ),
                            buildText('Address', address!),

                          ])),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
              ),
            ),
            const SizedBox(height: 10),
            RadioListTile(
              value: 1,
              groupValue: selectedValue,
              activeColor: primaryColor,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                  paymentmethod = 'cash on Delivery';
                });
              },
              title: const Text(
                'Cash On Delivery',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'Pay Cash At Home',
                style:
                    TextStyle(fontFamily: 'muli', color: Colors.grey.shade700),
              ),
            ),
            RadioListTile(
                value: 2,
                activeColor: primaryColor,
                groupValue: selectedValue,
                onChanged: (int? value) {
                  setState(() {
                    selectedValue = value!;
                    paymentmethod = 'online';
                  });
                },
                title: const Text(
                  "Pay Now",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Online Payment',
                  style: TextStyle(
                      fontFamily: 'muli', color: Colors.grey.shade700),
                ))
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            String datetime = DateTime.now().toString();

            log(datetime.toString());

            orderPlace(widget.cart, vm.totalPrice.toString(), paymentmethod!,
                datetime, name!, address!, phone!);
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primaryColor),
            child: const Center(
              child: Text(
                "Checkout",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomBar(context),
    );
  }
}
