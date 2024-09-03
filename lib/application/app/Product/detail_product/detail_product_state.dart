// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/product/detail_product/detail_product_model.dart';

class DetailProductState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final DetailProductModel detailProduct;
  final List<File> productImages;
  const DetailProductState({
    required this.loading,
    required this.failure,
    required this.detailProduct,
    required this.productImages,
  });

  DetailProductState copyWith({
    bool? loading,
    CleanFailure? failure,
    DetailProductModel? detailProduct,
    List<File>? productImages,
  }) {
    return DetailProductState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      detailProduct: detailProduct ?? this.detailProduct,
      productImages: productImages ?? this.productImages,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        loading,
        failure,
        detailProduct,
        productImages,
      ];

  factory DetailProductState.init() => DetailProductState(
        loading: false,
        failure: CleanFailure.none(),
        detailProduct: DetailProductModel.init(),
        productImages: const [],
      );
}
