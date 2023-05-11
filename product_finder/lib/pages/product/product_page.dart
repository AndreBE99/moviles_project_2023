import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/models/producto.dart';
import 'package:product_finder/pages/favorites/bloc/favorites_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = false;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoritesBloc>(context)
        .add(CheckIsFavoriteEvent(product: widget.product));

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
        title: Text(widget.product.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Image.network(
                  widget.product.imageUrl,
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
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
                            '${widget.product.description}',
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
                              'Precio: \$${widget.product.price}',
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
                                await launchUrl(widget.product.url);
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
              child: BlocConsumer<FavoritesBloc, FavoritesState>(
                listener: (context, state) {
                  if (state is FavoriteCheckedState) {
                    setState(() {
                      isFavorite = state.isFavorite;
                    });
                  }
                  if (state is FavoriteAddedState ||
                      state is FavoriteRemovedState) {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          isFavorite ? Colors.grey : Colors.red),
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        BlocProvider.of<FavoritesBloc>(context).add(
                            RemoveFromFavoritesEvent(product: widget.product));
                      } else {
                        BlocProvider.of<FavoritesBloc>(context)
                            .add(AddToFavoritesEvent(product: widget.product));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(isFavorite
                            ? 'Eliminar de Favoritos  '
                            : 'Añadir a Favoritos  '),
                        Icon(Icons.favorite, color: Colors.white),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> launchUrl(String url) async {
    try {
      await launchUrlString(url);
    } catch (error) {
      throw 'No se pudo abrir el enlace $url. Error: $error';
    }
  }
}
