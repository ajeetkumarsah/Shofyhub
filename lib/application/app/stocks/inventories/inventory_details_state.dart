import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_vendor/domain/app/stocks/inventories/inventory_details_model/inventory_details_model.dart';

class InventoryDetailsState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final InventoryDetailsModel inventoryDetails;
  const InventoryDetailsState({
    required this.loading,
    required this.failure,
    required this.inventoryDetails,
  });

  InventoryDetailsState copyWith({
    bool? loading,
    CleanFailure? failure,
    InventoryDetailsModel? inventoryDetails,
  }) {
    return InventoryDetailsState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      inventoryDetails: inventoryDetails ?? this.inventoryDetails,
    );
  }

  @override
  String toString() =>
      'InventoryDetailsState(loading: $loading, failure: $failure, inventoryDetails: $inventoryDetails)';

  @override
  List<Object> get props => [loading, failure, inventoryDetails];
  factory InventoryDetailsState.init() => InventoryDetailsState(
        loading: false,
        failure: CleanFailure.none(),
        inventoryDetails: InventoryDetailsModel.init(),
      );
}
