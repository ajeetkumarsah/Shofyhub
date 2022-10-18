import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_details_model.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_model.dart';

class SupplierDetailsState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final SupplierDetailsModel supplierDetails;
  const SupplierDetailsState({
    required this.loading,
    required this.failure,
    required this.supplierDetails,
  });

  SupplierDetailsState copyWith({
    bool? loading,
    CleanFailure? failure,
    SupplierDetailsModel? supplierDetails,
  }) {
    return SupplierDetailsState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      supplierDetails: supplierDetails ?? this.supplierDetails,
    );
  }

  @override
  String toString() {
    return 'SupplierDetailsState(loading: $loading, failure: $failure, supplierDetails: $supplierDetails)';
  }

  @override
  List<Object> get props => [loading, failure, supplierDetails];
  factory SupplierDetailsState.init() => SupplierDetailsState(
      loading: false,
      failure: CleanFailure.none(),
      supplierDetails: SupplierDetailsModel.init());
}
