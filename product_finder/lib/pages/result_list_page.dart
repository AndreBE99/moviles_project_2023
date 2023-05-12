import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:product_finder/models/producto.dart';
import 'package:product_finder/pages/product/product_page.dart';

class ResultList extends StatelessWidget {
  final List<Product> products;

  ResultList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Colors.grey,
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Product List'),
        centerTitle: true,
      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance.collection("products"),
        itemBuilder: (context, snapshot) {
          return Text("${snapshot["name"]}");
        },
      ),
    );
  }
}
