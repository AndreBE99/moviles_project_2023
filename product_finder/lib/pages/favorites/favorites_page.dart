import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/models/producto.dart';
import 'package:product_finder/pages/favorites/bloc/favorites_bloc.dart';
import 'package:product_finder/pages/product/product_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoritesBloc>(context).add(LoadFavoritesEvent());

    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/favorites.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 15),
                    child: Text(
                      "Favorite List",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                Row()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
