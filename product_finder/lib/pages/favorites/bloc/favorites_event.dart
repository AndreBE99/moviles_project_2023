part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

class AddToFavoritesEvent extends FavoritesEvent {
  final Product product;

  AddToFavoritesEvent({required this.product});
}

class RemoveFromFavoritesEvent extends FavoritesEvent {
  final Product product;

  RemoveFromFavoritesEvent({required this.product});
}

class CheckIsFavoriteEvent extends FavoritesEvent {
  final Product product;

  CheckIsFavoriteEvent({required this.product});
}

class LoadFavoritesEvent extends FavoritesEvent {}

class SignOutEvent2 extends FavoritesEvent {}
