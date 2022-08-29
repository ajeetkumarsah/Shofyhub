// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/app/Product/product_model.dart';

class ProductState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<ProductModel> productList;

  const ProductState({
    required this.loading,
    required this.failure,
    required this.productList,
  });

  ProductState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<ProductModel>? productList,
    Unit? updateProduct,
  }) {
    return ProductState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      productList: productList ?? this.productList,
    );
  }

  @override
  String toString() =>
      'ProductState(loading: $loading, failure: $failure, productList: $productList)';

  @override
  List<Object> get props => [
        loading,
        failure,
        productList,
      ];
  factory ProductState.init() => ProductState(
        loading: false,
        failure: CleanFailure.none(),
        productList: const [],
      );

  @override
  bool get stringify => true;
}
