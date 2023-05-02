import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:product_finder/models/producto.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final List<Product> _favorites = [];

  FavoritesBloc() : super(FavoritesEmptyState()) {
    on<AddToFavoritesEvent>(_addToFavorites);
    on<RemoveFromFavoritesEvent>(_removeFromFavorites);
    on<CheckIsFavoriteEvent>(_checkIsFavorite);
    on<LoadFavoritesEvent>(_loadFavorites);
  }

  FutureOr<void> _addToFavorites(AddToFavoritesEvent event, emit) async {
    _favorites.add(event.product);
    print('Agregar a favoritos: ${event.product.name}');
    emit(FavoriteAddedState());
  }

  FutureOr<void> _removeFromFavorites(
      RemoveFromFavoritesEvent event, emit) async {
    _favorites.remove(event.product);
    print('Eliminar de favoritos: ${event.product.name}');
    emit(FavoriteRemovedState());
  }

  FutureOr<void> _checkIsFavorite(CheckIsFavoriteEvent event, emit) async {
    final isFavorite =
        _favorites.any((product) => product.url == event.product.url);
    emit(FavoriteCheckedState(isFavorite: isFavorite));
  }

  FutureOr<void> _loadFavorites(LoadFavoritesEvent event, emit) async {
    print('Cargando favoritos');
    if (_favorites.isEmpty) {
      emit(FavoritesEmptyState());
    } else {
      emit(FavoritesLoadedState(favorites: _favorites));
    }
  }
}
