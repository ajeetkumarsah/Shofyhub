import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_model.dart';

class ManufacturerState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<ManufacturerModel> manufacturerList;
  final List<ManufacturerModel> trashManufacturerList;

  const ManufacturerState({
    required this.loading,
    required this.failure,
    required this.manufacturerList,
    required this.trashManufacturerList,
  });

  ManufacturerState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<ManufacturerModel>? manufacturerList,
    final List<ManufacturerModel>? trashManufacturerList,
  }) {
    return ManufacturerState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      manufacturerList: manufacturerList ?? this.manufacturerList,
      trashManufacturerList:
          trashManufacturerList ?? this.trashManufacturerList,
    );
  }

  @override
  String toString() {
    return 'ManufacturerState(loading: $loading, failure: $failure, manufacturerList: $manufacturerList, manufacturerList: $trashManufacturerList)';
  }

  @override
  List<Object> get props => [loading, failure, manufacturerList];

  factory ManufacturerState.init() => ManufacturerState(
        loading: false,
        failure: CleanFailure.none(),
        manufacturerList: const [],
        trashManufacturerList: const [],
      );
}
