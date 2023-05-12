import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:product_finder/models/producto.dart';

Future<List<Product>> getProductListFromJson(
    String searchValue, bool op) async {
  String jsonString = await rootBundle.loadString('assets/product.json');
  List<dynamic> jsonResponse = jsonDecode(jsonString);
  if (op == false) {
    List<Product> productList = jsonResponse
        .map((product) => Product.fromJson(product))
        .where((product) =>
            product.name.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
    return productList;
  } else {
    List<Product> productList = jsonResponse
        .map((product) => Product.fromJson(product))
        .where((product) =>
            product.barcode.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
    return productList;
  }
}
