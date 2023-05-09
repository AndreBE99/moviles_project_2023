part of 'product_bloc.dart';

abstract class ProductEvent {
  final String searchValue;

  ProductEvent({required this.searchValue});

  List<Object> get props => [searchValue];
}

class LoadProductListEvent extends ProductEvent {
  LoadProductListEvent({required super.searchValue});
}
