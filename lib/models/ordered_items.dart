class OrderedItem {
  final String itemName;
  final double price;
  final String image; // Image URL or path

  OrderedItem({
    required this.itemName,
    required this.price,
    required this.image,
  });
}

class Order {
  final DateTime date;
  final List<OrderedItem> items;
  final String? paymentMode;

  Order({
    required this.date,
    required this.items,
    required this.paymentMode,
  });
}

List<Order> ordersData = [
  Order(
    date: DateTime(2023, 9, 17),
    items: [
      OrderedItem(
        itemName: 'Dresses',
        price: 899,
        image: 'assets/images/dress.png', 
      ),
      OrderedItem(
        itemName: 'Tshirt',
        price: 299,
        image: 'assets/images/tshirt.png', 
      ),
    ],
    paymentMode: 'Cash on Delivery',
  ),
  Order(
    date: DateTime(2023, 11, 10),
    items: [
      OrderedItem(
        itemName: 'IPhone',
        price: 899,
        image: 'assets/images/iphone.png', 
      ),
    ],
    paymentMode: 'Credit Card',
  ),
];
