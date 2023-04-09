import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/pages/bloc/product_bloc.dart';
import 'package:product_finder/pages/result_list_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<ProductBloc>(context).add(LoadProductListEvent());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductListLoadedState) {
                      return ResultList(products: state.productList);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            );
          },
          child: Text('Lista de productos'),
        ),
      ),
    );
  }
}
