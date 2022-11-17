import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/shop/delivery%20boy/delivary_boy_model.dart';

class DelivaryBoyState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<DelivaryBoyModel> delivaryBoyList;
  final List<DelivaryBoyModel> trashDelivaryBoyList;
  const DelivaryBoyState({
    required this.loading,
    required this.failure,
    required this.delivaryBoyList,
    required this.trashDelivaryBoyList,
  });

  DelivaryBoyState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<DelivaryBoyModel>? delivaryBoyList,
    List<DelivaryBoyModel>? trashDelivaryBoyList,
  }) {
    return DelivaryBoyState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      delivaryBoyList: delivaryBoyList ?? this.delivaryBoyList,
      trashDelivaryBoyList: trashDelivaryBoyList ?? this.trashDelivaryBoyList,
    );
  }

  @override
  String toString() =>
      'DelivaryBoyState(loading: $loading, failure: $failure, delivaryBoyList: $delivaryBoyList, trashDelivaryBoyList: $trashDelivaryBoyList)';

  @override
  List<Object> get props => [
        loading,
        failure,
        delivaryBoyList,
        trashDelivaryBoyList,
      ];

  factory DelivaryBoyState.init() => DelivaryBoyState(
        loading: false,
        failure: CleanFailure.none(),
        delivaryBoyList: const [],
        trashDelivaryBoyList: const [],
      );
}
