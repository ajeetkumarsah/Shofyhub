import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_details_model.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_model.dart';

class SupplierState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<SupplierModel> allSuppliers;
  final List<SupplierModel> trashSupplier;
  const SupplierState({
    required this.loading,
    required this.failure,
    required this.allSuppliers,
    required this.trashSupplier,
  });

  SupplierState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<SupplierModel>? allSuppliers,
    List<SupplierModel>? trashSupplier,
  }) {
    return SupplierState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      allSuppliers: allSuppliers ?? this.allSuppliers,
      trashSupplier: trashSupplier ?? this.trashSupplier,
    );
  }

  @override
  String toString() {
    return 'SupplierState(loading: $loading, failure: $failure, allSuppliers: $allSuppliers, trashSupplier: $trashSupplier)';
  }

  @override
  List<Object> get props => [loading, failure, allSuppliers, trashSupplier];
  factory SupplierState.init() => SupplierState(
        loading: false,
        failure: CleanFailure.none(),
        allSuppliers: const [],
        trashSupplier: const [],
      );
}
