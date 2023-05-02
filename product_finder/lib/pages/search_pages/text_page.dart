import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/pages/product/bloc/product_bloc.dart';
import 'package:product_finder/pages/result_list_page.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Material App Bar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 68),
                    Text(
                      'Flutter Met',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your place for searching ART',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<ProductBloc>(context)
                    .add(LoadProductListEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BlocBuilder<ProductBloc, ProductState>(
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
              child: Text('Search'),
            ),
          ),
        ],
      ),
    );
  }
}
