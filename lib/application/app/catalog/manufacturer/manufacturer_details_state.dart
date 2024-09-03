import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:alpesportif_seller/domain/app/catalog/manufacturer/manufacturer_details_model.dart';

class ManufacturerDetailsState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final ManufacturerDetailsModel manufacturerDetails;
  const ManufacturerDetailsState({
    required this.loading,
    required this.failure,
    required this.manufacturerDetails,
  });

  ManufacturerDetailsState copyWith({
    bool? loading,
    CleanFailure? failure,
    ManufacturerDetailsModel? manufacturerDetails,
  }) {
    return ManufacturerDetailsState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      manufacturerDetails: manufacturerDetails ?? this.manufacturerDetails,
    );
  }

  @override
  String toString() =>
      'ManufacturerDetailsState(loading: $loading, failure: $failure, manufacturerDetails: $manufacturerDetails)';

  @override
  List<Object> get props => [loading, failure, manufacturerDetails];

  factory ManufacturerDetailsState.init() => ManufacturerDetailsState(
      loading: false,
      failure: CleanFailure.none(),
      manufacturerDetails: ManufacturerDetailsModel.inti());
}
