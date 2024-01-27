import "dart:convert";
import 'dart:developer';

import 'package:ecommerce_app/models/categorylist_model.dart';
import 'package:ecommerce_app/models/user_datamodel.dart';
import 'package:http/http.dart' as http;

import '../models/orderdetails_model.dart';
import '../models/product_model.dart';



// ignore: camel_case_types
class webservice {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';

  static const mainurl = 'https://bootcamp.cyralearnings.com/';

  Future<List<CategoryModel>?> fetchCategory() async {
    try {
      log("${mainurl}getcategories.php");

      final response =
          await http.post(Uri.parse("${mainurl}getcategories.php"));

      log(response.body);

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        //log(parsed.toString());
        return parsed
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load Category");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ProductModel>> fetchCatProducts(int catid) async {
    log("catid == $catid");
    final response = await http.post(
        Uri.parse('${mainurl}get_category_products.php'),
        body: {"catid": catid.toString()});
    log('statuscode == ${response.statusCode}');
    if (response.statusCode == 200) {
      log("response == ${response.body}");
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load category products");
    }
  }

  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.post(Uri.parse('${mainurl}view_offerproducts.php'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load product!');
    }
  }

  Future<UserDataModel?> fetchUser(String username) async {
    try {
      final response = await http.post(Uri.parse('${mainurl}get_user.php'),
          body: {'username': username});

      if (response.statusCode == 200) {
        return UserDataModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load user");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
Future<List<OrderModel>?> fetchOrderDetails(String username) async {
  try {
    log("username == $username");
    final responseFromHttp = await http.post(
      Uri.parse('${mainurl}get_orderdetails.php'),
      body: {'username': username.toString()},
    );

    print("API Response: ${responseFromHttp.body}");

    if (responseFromHttp.statusCode == 200) {
      // Check if the response is a JSON array
      if (responseFromHttp.body.startsWith('[') && responseFromHttp.body.endsWith(']')) {
        final parsed = json.decode(responseFromHttp.body);
        if (parsed is List) {
          return parsed
              .map<OrderModel>((json) => OrderModel.fromJson(json))
              .toList();
        } else {
          throw Exception("Invalid JSON array format");
        }
      } else {
        throw Exception("Invalid JSON format");
      }
    } else {
      throw Exception("Failed to load order details. Status code: ${responseFromHttp.statusCode}");
    }
  } catch (e) {
    log("order details == $e");
    return null;
  }
}


}
