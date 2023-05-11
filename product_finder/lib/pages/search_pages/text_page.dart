import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/pages/product/bloc/product_bloc.dart';
import 'package:product_finder/pages/result_list_page.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final _searchValue = TextEditingController();

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
                    image: AssetImage('assets/images/buscar3.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchValue,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 15),
              child: SizedBox(
                width: 125,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context).add(
                        LoadProductListEvent(
                            searchValue: _searchValue.text.trim(), op: false));
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
            ),
          ),
        ],
      ),
    );
  }
}
