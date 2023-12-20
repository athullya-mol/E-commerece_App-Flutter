import 'package:ecommerce_app/constants/const.dart';
import 'package:ecommerce_app/models/ordered_items.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

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
          color: primaryColor,
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(
              fontSize: 26,
              color: primaryColor,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: ordersData.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 3,
                    child: ExpansionTile(
                      backgroundColor: Colors.grey.shade200,
                      title: ListTile(
                        title: Text(
                          formatDate(
                            ordersData[index].date,
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        isThreeLine: true,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ordersData[index].paymentMode!,
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize:  16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Total Price: Rs.${calculateTotalPrice(ordersData[index].items)}',
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize:  16,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Column(
                          
                          children: ordersData[index]
                              .items
                              .map(
                                (item) => Container(
                                  height: 100,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: ListTile(
                                    leading: Image.asset(
                                      item.image,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.contain,
                                      
                                    ),
                                    title: Text(item.itemName,
                                    style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize:  18,
                              ),
                                    ),
                                    subtitle: Text('Price: Rs.${item.price}',
                                    style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize:  16,
                                fontWeight: FontWeight.w500
                              ),
                                    
                                    ),
                                    trailing: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        '1x',
                                        style: TextStyle(
                                            color: Colors.green.shade800,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('E, MMM d, y').format(date); // Format the DateTime object
  }

  double calculateTotalPrice(List<OrderedItem> items) {
    return items.fold(0, (sum, item) => sum + item.price);
  }
}
