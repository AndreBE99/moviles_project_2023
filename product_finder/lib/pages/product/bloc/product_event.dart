part of 'product_bloc.dart';

abstract class ProductEvent {
  final String searchValue;
  final bool op;

  ProductEvent({required this.searchValue, required this.op});

  List<Object> get props => [searchValue];
}

class LoadProductListEvent extends ProductEvent {
  LoadProductListEvent({required super.searchValue, required super.op});
}
