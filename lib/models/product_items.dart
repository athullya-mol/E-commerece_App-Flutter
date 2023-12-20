class Product {
  final String image;
  final String title;
  final String price;

  Product({
    required this.image,
    required this.title,
    required this.price,
  });
}

class ProductItems {
  List<Product> products= [
    Product(image: "Blazersjacket", title: "Blazers", price: "Rs.3000"),
    Product(image: "dress", title: "Dresses", price: "Rs.899"),
    Product(image: "fridge", title: "Fridge", price: "Rs.35000"),
    Product(image: "iphone", title: "IPhone", price: "Rs.125000"),
    Product(image: "jump", title: "Jumpsuits", price: "Rs.1299"),
    Product(image: "long-sleeves", title: "Shirt", price: "Rs.499"),
    Product(image: "tshirt", title: "Tshirt", price: "Rs.299"),
    Product(image: "shoes", title: "Shoes", price: "Rs.2799"),
    Product(image: "s23", title: "Samsung S23", price: "Rs.115000"),
    Product(image: "saree", title: "Saree", price: "Rs.3799")
  ];
}
  class ProductMenItems {
  List<Product> products= [
    Product(image: "Blazersjacket", title: "Blazers", price: "Rs.3000"),
    Product(image: "long-sleeves", title: "Shirt", price: "Rs.499"),
    Product(image: "tshirt", title: "Tshirt", price: "Rs.299"),
    Product(image: "shoes", title: "Shoes", price: "Rs.2799"),
  ];  
}
class ProductElectronicsItems {
  List<Product> products= [
    Product(image: "iphone", title: "IPhone", price: "Rs.125000"),
    Product(image: "s23", title: "Samsung S23", price: "Rs.115000"),
    Product(image: "fridge", title: "Fridge", price: "Rs.35000"),
  ];  
}

class ProductWomenItems {
  List<Product> products= [
    Product(image: "jump", title: "Jumpsuit", price: "Rs.1299"),
    Product(image: "dress", title: "Dresses", price: "Rs.899"),
    Product(image: "saree", title: "Saree", price: "Rs.3799"),
  ];  
}
