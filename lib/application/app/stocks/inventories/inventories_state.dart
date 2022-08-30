import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/stocks/inventories/inventories_model.dart';

class InventoriesState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<InventoriesModel> allInventories;
  const InventoriesState({
    required this.loading,
    required this.failure,
    required this.allInventories,
  });

  InventoriesState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<InventoriesModel>? allInventories,
  }) {
    return InventoriesState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      allInventories: allInventories ?? this.allInventories,
    );
  }

  @override
  String toString() =>
      'InventoriesState(loading: $loading, failure: $failure, allInventories: $allInventories)';

  @override
  List<Object> get props => [loading, failure, allInventories];
  factory InventoriesState.init() => InventoriesState(
        loading: false,
        failure: CleanFailure.none(),
        allInventories: const [],
      );
}
