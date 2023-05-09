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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          'Lista de productos',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
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
