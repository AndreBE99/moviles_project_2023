import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/models/producto.dart';
import 'package:product_finder/pages/favorites/bloc/favorites_bloc.dart';
import 'package:product_finder/pages/product/product_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoritesBloc>(context).add(LoadFavoritesEvent());

    return Scaffold(
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoadedState) {
            final favorites = state.favorites;
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                Product product = favorites[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
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
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      BlocProvider.of<FavoritesBloc>(context)
                          .add(RemoveFromFavoritesEvent(product: product));
                    },
                  ),
                );
              },
            );
          } else if (state is FavoritesEmptyState) {
            return Center(
              child: Text('No hay productos en la lista de favoritos.'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
