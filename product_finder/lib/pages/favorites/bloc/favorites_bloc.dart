import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:product_finder/models/producto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavoritesBloc() : super(FavoritesEmptyState()) {
    on<AddToFavoritesEvent>(_addToFavorites);
    on<RemoveFromFavoritesEvent>(_removeFromFavorites);
    on<CheckIsFavoriteEvent>(_checkIsFavorite);
    on<LoadFavoritesEvent>(_loadFavorites);
  }

  FutureOr<void> _addToFavorites(AddToFavoritesEvent event, emit) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .add(event.product.toJson());
      print('Agregar a favoritos: ${event.product.name}');
      emit(FavoriteAddedState());
    }
  }

  FutureOr<void> _removeFromFavorites(
      RemoveFromFavoritesEvent event, emit) async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .where('url', isEqualTo: event.product.url)
          .get();

      if (!snapshot.docs.isEmpty) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .doc(snapshot.docs.first.id)
            .delete();

        print('Eliminar de favoritos: ${event.product.name}');
        emit(FavoriteRemovedState());
      }
    }
    // Agrega a la cola de eventos la carga de favoritos
    add(LoadFavoritesEvent());
  }

  FutureOr<void> _checkIsFavorite(CheckIsFavoriteEvent event, emit) async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .where('url', isEqualTo: event.product.url)
          .get();

      emit(FavoriteCheckedState(isFavorite: !snapshot.docs.isEmpty));
    }
  }

  FutureOr<void> _loadFavorites(LoadFavoritesEvent event, emit) async {
    print('Cargando favoritos');
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .get();

      if (snapshot.docs.isEmpty) {
        emit(FavoritesEmptyState());
      } else {
        try {
          final favorites =
              snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
          emit(FavoritesLoadedState(favorites: favorites));
        } catch (e) {
          print("ERROR: ${e}");
        }
      }
    } else {
      print("USER == NULL");
    }
  }
}
