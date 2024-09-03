// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:alpesportif_seller/domain/app/carriers/carrier_model.dart';

class CarriersState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<CarrierModel> carriers;
  const CarriersState({
    required this.loading,
    required this.failure,
    required this.carriers,
  });

  CarriersState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<CarrierModel>? carriers,
  }) {
    return CarriersState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      carriers: carriers ?? this.carriers,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, carriers];

  factory CarriersState.init() => CarriersState(
      loading: false, failure: CleanFailure.none(), carriers: const []);
}
