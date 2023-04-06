import 'package:flutter/material.dart';
import 'package:product_finder/pages/login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool bandera = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Scaffold(
            body: bandera ? temp : LoginPage(),
          ),
        ),
      ),
    );
  }
}

Widget temp = Container(
  child: Text('Hola mundo'),
);
