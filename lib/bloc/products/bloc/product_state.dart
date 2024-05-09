

import 'package:ecomfix/models/products/top-rated-product.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}


class ProductLoadingState extends ProductState {}


class ProductLoadedState extends ProductState {
  List<Products> products;
  ProductLoadedState({required this.products});
}


class ProductErrorState extends ProductState {
  String errorMsg;
  ProductErrorState({required this.errorMsg});
}