import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_model.dart';

class WarehouseState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<WarehouseModel> warehouseItemList;
  final List<WarehouseModel> trashWarehouses;
  const WarehouseState({
    required this.loading,
    required this.failure,
    required this.warehouseItemList,
    required this.trashWarehouses,
  });

  WarehouseState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<WarehouseModel>? warehouseItemList,
    List<WarehouseModel>? trashWarehouses,
  }) {
    return WarehouseState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      warehouseItemList: warehouseItemList ?? this.warehouseItemList,
      trashWarehouses: trashWarehouses ?? this.trashWarehouses,
    );
  }

  @override
  String toString() =>
      'WarehouseState(loading: $loading, failure: $failure, warehouseItemList: $warehouseItemList, trashWarehouses: $trashWarehouses)';

  @override
  List<Object> get props =>
      [loading, failure, warehouseItemList, trashWarehouses];

  factory WarehouseState.init() => WarehouseState(
        loading: false,
        failure: CleanFailure.none(),
        warehouseItemList: const [],
        trashWarehouses: const [],
      );
}
