import 'package:flutter/material.dart';
import 'package:product_finder/models/producto.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage({super.key, required this.product});

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
            product.name,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontFamily: 'Playfair Display',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          height: 30,
                          thickness: 0.5,
                          color: Colors.grey[300],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                          child: Text(
                            '${product.description}',
                            style: TextStyle(
                              fontFamily: 'Playfair Display',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                                height: 30,
                                thickness: 0.5,
                                color: Colors.grey[300]),
                            Text(
                              'Precio: \$${product.price}',
                              style: TextStyle(
                                fontFamily: 'Playfair Display',
                                color: Color(0xFF1E2429),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                            child: InkWell(
                              onTap: () async {
                                await launchUrl(product.url);
                              },
                              child: Text(
                                'Visita el sitio web',
                                style: TextStyle(
                                  fontFamily: 'Playfair Display',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                )
              ]),
            ),
          ),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Añadir a Favoritos  '),
                    Icon(Icons.favorite, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  Future<void> launchUrl(String url) async {
    try {
      await launchUrlString(url);
    } catch (error) {
      throw 'No se pudo abrir el enlace $url. Error: $error';
    }
  }
}
