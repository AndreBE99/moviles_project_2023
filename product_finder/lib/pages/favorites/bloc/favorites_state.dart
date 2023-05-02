part of 'favorites_bloc.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoriteAddedState extends FavoritesState {}

class FavoriteRemovedState extends FavoritesState {}

class FavoriteCheckedState extends FavoritesState {
  final bool isFavorite;
  FavoriteCheckedState({required this.isFavorite});
}

class FavoritesLoadedState extends FavoritesState {
  final List<Product> favorites;
  FavoritesLoadedState({required this.favorites});
}

class FavoritesEmptyState extends FavoritesState {}
