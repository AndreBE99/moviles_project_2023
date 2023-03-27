import 'package:flutter/material.dart';
import 'package:product_finder/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
