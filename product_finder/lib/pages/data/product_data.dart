import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:product_finder/models/producto.dart';

Future<List<Product>> getProductListFromJson() async {
  String jsonString = await rootBundle.loadString('assets/product.json');
  List<dynamic> jsonResponse = jsonDecode(jsonString);
  return jsonResponse.map((product) => Product.fromJson(product)).toList();
}
