// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/Product/create_product/manufacturer_id.dart';
import 'package:zcart_seller/domain/app/Product/create_product/tag_list.dart';

import '../../../domain/app/Product/create_product/gtin_types_model.dart';
import '../../../domain/app/Product/product_model.dart';

class ProductState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<ProductModel> productList;
  final List<GtinTypes> gtinTypes;
  final List<TagListModel> tagList;
  final List<ManufacturerId> manufacturerId;

  const ProductState({
    required this.loading,
    required this.failure,
    required this.productList,
    required this.gtinTypes,
    required this.tagList,
    required this.manufacturerId,
  });

  ProductState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<ProductModel>? productList,
    List<GtinTypes>? gtinTypes,
    List<TagListModel>? tagList,
    List<ManufacturerId>? manufacturerId,
  }) {
    return ProductState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      productList: productList ?? this.productList,
      gtinTypes: gtinTypes ?? this.gtinTypes,
      tagList: tagList ?? this.tagList,
      manufacturerId: manufacturerId ?? this.manufacturerId,
    );
  }

  @override
  String toString() =>
      'ProductState(loading: $loading, failure: $failure, productList: $productList)';

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      productList,
      gtinTypes,
      tagList,
      manufacturerId,
    ];
  }

  factory ProductState.init() => ProductState(
        loading: false,
        failure: CleanFailure.none(),
        productList: const [],
        gtinTypes: const [],
        tagList: const [],
        manufacturerId: const [],
      );

  @override
  bool get stringify => true;
}
