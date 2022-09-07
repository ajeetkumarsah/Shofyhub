// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/product/detail_product/detail_product_model.dart';

class DetailProductState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final DetailProductModel detailProduct;
  const DetailProductState({
    required this.loading,
    required this.failure,
    required this.detailProduct,
  });

  DetailProductState copyWith({
    bool? loading,
    CleanFailure? failure,
    DetailProductModel? detailProduct,
  }) {
    return DetailProductState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      detailProduct: detailProduct ?? this.detailProduct,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, detailProduct];

  factory DetailProductState.init() => DetailProductState(
      loading: false,
      failure: CleanFailure.none(),
      detailProduct: DetailProductModel.init());
}
