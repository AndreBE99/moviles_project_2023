import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:product_finder/models/producto.dart';
import 'package:product_finder/data/product_data.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProductListEvent>(_loadProductList);
  }

  FutureOr<void> _loadProductList(
      LoadProductListEvent event, Emitter emit) async {
    try {
      List<Product> productList = await getProductListFromJson(
          event.searchValue, event.op, event.range);
      emit(ProductListLoadedState(productList: productList));
    } catch (e) {
      emit(ProductErrorState(errorMessage: e.toString()));
    }
  }
}
