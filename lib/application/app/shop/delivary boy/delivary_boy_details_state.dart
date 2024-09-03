import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:alpesportif_seller/domain/app/shop/delivery%20boy/delivary_boy_model.dart';

class DelivaryBoyDetailsState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final DelivaryBoyModel delivaryBoyDetails;
  const DelivaryBoyDetailsState({
    required this.loading,
    required this.failure,
    required this.delivaryBoyDetails,
  });

  DelivaryBoyDetailsState copyWith({
    bool? loading,
    CleanFailure? failure,
    DelivaryBoyModel? delivaryBoyDetails,
  }) {
    return DelivaryBoyDetailsState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      delivaryBoyDetails: delivaryBoyDetails ?? this.delivaryBoyDetails,
    );
  }

  @override
  String toString() =>
      'DelivaryBoyDetailsState(loading: $loading, failure: $failure, delivaryBoyDetails: $delivaryBoyDetails)';

  @override
  List<Object> get props => [loading, failure, delivaryBoyDetails];

  factory DelivaryBoyDetailsState.init() => DelivaryBoyDetailsState(
      loading: false,
      failure: CleanFailure.none(),
      delivaryBoyDetails: DelivaryBoyModel.init());
}
