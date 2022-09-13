import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/stocks/inventories/inventories_model.dart';

class InventoriesState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<InventoriesModel> allInventories;
  final List<InventoriesModel> trashInventory;
  const InventoriesState({
    required this.loading,
    required this.failure,
    required this.allInventories,
    required this.trashInventory,
  });

  InventoriesState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<InventoriesModel>? allInventories,
    List<InventoriesModel>? trashInventory,
  }) {
    return InventoriesState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      allInventories: allInventories ?? this.allInventories,
      trashInventory: trashInventory ?? this.trashInventory,
    );
  }

  @override
  String toString() {
    return 'InventoriesState(loading: $loading, failure: $failure, allInventories: $allInventories, trashInventory: $trashInventory)';
  }

  @override
  List<Object> get props => [loading, failure, allInventories, trashInventory];
  factory InventoriesState.init() => InventoriesState(
        loading: false,
        failure: CleanFailure.none(),
        allInventories: const [],
        trashInventory: const [],
      );
}
