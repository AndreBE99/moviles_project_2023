import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/models/producto.dart';
import 'package:product_finder/pages/product/bloc/product_bloc.dart';
import 'package:product_finder/pages/product/product_page.dart';

class ResultList extends StatefulWidget {
  final List<Product> products;
  final double range;

  ResultList({super.key, required this.products, required this.range});

  @override
  State<ResultList> createState() => _ResultListState();
}

class _ResultListState extends State<ResultList> {
  TextEditingController priceRangeController = TextEditingController();

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
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return Container(
            //margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
              ),
              title: Text(product.name),
              subtitle: Text('Precio: \$${product.price}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filtrar productos'),
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: priceRangeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Precio máximo',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductListLoadedState) {
                          return ResultList(
                            products: state.productList,
                            range: double.parse(priceRangeController.text),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                );
              },
              child: Text('Filtrar'),
            )
          ],
        );
      },
    );
  }
}
