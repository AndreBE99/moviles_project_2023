// import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
import 'package:product_finder/models/producto.dart';

Future<List<Product>> getProductListFromJson(String searchValue) async {
  // String jsonString = await rootBundle.loadString('assets/product.json');
  // List<dynamic> jsonResponse = jsonDecode(jsonString);
  // return jsonResponse.map((product) => Product.fromJson(product)).toList();
  var snapshot;
  // print("Searched value: ${searchValue}");
  try {
    snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('name', isEqualTo: searchValue)
        .get();
    // print(snapshot);
  } catch (e) {
    print("Error: ${e}");
  }

  final List<Product> products = snapshot.docs
      .map((doc) => doc.data() as List<Product>)
      .cast<Product>()
      .toList();

  return products;
}
