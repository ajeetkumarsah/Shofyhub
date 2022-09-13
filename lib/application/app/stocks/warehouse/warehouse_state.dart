import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_model.dart';

class WarehouseState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<WarehouseModel> warehouseItemList;
  const WarehouseState({
    required this.loading,
    required this.failure,
    required this.warehouseItemList,
  });

  WarehouseState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<WarehouseModel>? warehouseItemList,
  }) {
    return WarehouseState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      warehouseItemList: warehouseItemList ?? this.warehouseItemList,
    );
  }

  @override
  String toString() =>
      'WarehouseState(loading: $loading, failure: $failure, warehouseItemList: $warehouseItemList)';

  @override
  List<Object> get props => [loading, failure, warehouseItemList];

  factory WarehouseState.init() => WarehouseState(
      loading: false,
      failure: CleanFailure.none(),
      warehouseItemList: const []);
}
