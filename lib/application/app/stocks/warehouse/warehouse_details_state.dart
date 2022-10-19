import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_details_model.dart';

class WarehouseDetailsState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final WarehouseDetailsModel warehouseDetails;
  const WarehouseDetailsState({
    required this.loading,
    required this.failure,
    required this.warehouseDetails,
  });

  WarehouseDetailsState copyWith({
    bool? loading,
    CleanFailure? failure,
    WarehouseDetailsModel? warehouseDetails,
  }) {
    return WarehouseDetailsState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      warehouseDetails: warehouseDetails ?? this.warehouseDetails,
    );
  }

  @override
  String toString() {
    return 'WarehouseDetailsState(loading: $loading, failure: $failure, warehouseDetails: $warehouseDetails)';
  }

  @override
  List<Object> get props => [loading, failure, warehouseDetails];
  factory WarehouseDetailsState.init() => WarehouseDetailsState(
      loading: false,
      failure: CleanFailure.none(),
      warehouseDetails: WarehouseDetailsModel.init());
}
