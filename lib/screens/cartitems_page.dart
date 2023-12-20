
import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/screens/checkout_page.dart';
// import 'package:ecommerce_app/screens/checkout_page.dart';
import 'package:ecommerce_app/services/provider/cart_provider.dart';
import 'package:ecommerce_app/widgets/bottom_bar.dart';
import 'package:ecommerce_app/widgets/buildcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class CartItemScreen extends StatefulWidget {
  
  const CartItemScreen({super.key});

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
//    List<CartProduct> cartList = [];

@override
void initState() {
  super.initState();
  Provider.of<CartProvider>(context, listen: false).fetchCartItems();

  // Fetch cart items when the screen initializes
}

// Method to fetch cart items
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Cart",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          actions: [
            Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return IconButton(
                onPressed: () {
                  if (cartProvider.cartList.isNotEmpty) {
                    cartProvider.clearCart();
                  }
                },
                icon: const Icon(Icons.delete),
                color: primaryColor,
                iconSize: 26,
              );
            },
          ),
          ],
        ),
         body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: Image.asset(
                      'assets/images/empty.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'Your Cart Is Empty!',
                    style: TextStyle(
                      fontSize: 26,
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: cartProvider.cartList.length,
              itemBuilder: (context, index) {
                final cartItem = cartProvider.cartList[index];
                return buildCartItem(context, cartItem, index, cartProvider);
              },
            );
          }
        },
      ),
  bottomSheet: Consumer<CartProvider>(
  builder: (context, cartProvider, child) {
     if (cartProvider.cartList.isNotEmpty) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total : ${cartProvider.calculateTotalPrice(cartProvider.cartList, cartProvider.productQuantities)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.red.shade800,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPage()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24, vertical: 18)),
              ),
              child: const Text(
                "Order Now",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    }
    else{
      return const SizedBox();
    }
  },
  
),

      bottomNavigationBar: bottomBar(context),
    );
    
  }


//   String calculateTotalPrice(List<CartProduct> cartList,Map<int, int> productQuantities) {
//     double totalPrice = 0;
//     for (int i = 0; i < cartList.length; i++) {
//       String price = cartList[i].price.toString().substring(3).replaceAll(',', '');
//       int itemPrice = int.tryParse(price) ?? 0;
//       int quantity = productQuantities[i] ?? 1;
//       totalPrice += itemPrice * quantity;
//     }
//     return 'Rs.${totalPrice.toStringAsFixed(2)}';
//   }
 }

