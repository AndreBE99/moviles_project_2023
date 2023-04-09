import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:product_finder/models/producto.dart';
import 'package:product_finder/pages/data/product_data.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProductListEvent>(_loadProductList);
  }

  FutureOr<void> _loadProductList(event, emit) async {
    try {
      List<Product> productList = await getProductListFromJson();
      emit(ProductListLoadedState(productList: productList));
    } catch (e) {
      emit(ProductErrorState(errorMessage: e.toString()));
    }
  }
}
