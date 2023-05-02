part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductListLoadedState extends ProductState {
  final List<Product> productList;

  ProductListLoadedState({required this.productList});
}

class ProductErrorState extends ProductState {
  final String errorMessage;

  ProductErrorState({required this.errorMessage});
}
