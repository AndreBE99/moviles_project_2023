import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/pages/bloc/product_bloc.dart';
import 'package:product_finder/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductBloc(),
        child: MaterialApp(
          title: 'Material App',
          home: HomePage(),
        ));
  }
}
