import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_app/models/categorylist_model.dart';
import 'package:ecommerce_app/models/orderdetails_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/user_datamodel.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';
  final String baseUrl = 'http://bootcamp.cyralearnings.com/';

  Future<List<CategoryModel>?> getCategories() async {
    try {
      final url = Uri.parse('${baseUrl}getcategories.php');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<ProductModel>> getCategoryProducts(int categoryId) async {
    log("catid ==$categoryId");
    final url = Uri.parse('${baseUrl}get_category_products.php');
    final response =
        await http.post(url, body: {'catid': categoryId.toString()});
    log("statuscode==${response.statusCode}");
    if (response.statusCode == 200) {
      log("response == ${response.body}");
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch category products');
    }
  }

  Future<List<ProductModel>> getOfferProducts() async {
    final url = Uri.parse('${baseUrl}view_offerproducts.php');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch offer products');
    }
  }

  Future<List<OrderModel>?> getOrderDetails(String username) async {
    try {
      log("username ==$username");
      final url = Uri.parse('${baseUrl}get_orderdetails.php');
      final response = await http.post(url, body: {'username': username});

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch order details');
      }
    } catch (e) {
      log("order details ==$e");
    }

    Future<UserDataModel?> getUser(String username) async {
      try {
        final url = Uri.parse('${baseUrl}get_user.php');
        final response = await http.post(url, body: {'username': username});

        if (response.statusCode == 200) {
          return UserDataModel.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to fetch user');
        }
      } catch (e) {
        log(e.toString());
      }
      return null;
    }
    return null;
  }
  
}
