part of 'product_bloc.dart';

abstract class ProductEvent {
  final String searchValue;
  final bool op;
  final double range;

  ProductEvent(
      {required this.searchValue, required this.op, required this.range});

  List<Object> get props => [searchValue, op, range];
}

class LoadProductListEvent extends ProductEvent {
  LoadProductListEvent(
      {required super.searchValue, required super.op, required super.range});
}
