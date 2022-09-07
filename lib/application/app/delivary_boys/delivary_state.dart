// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/delivary%20boy/delivary_boy_model.dart';

class DelivaryState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<DelivaryBoy> delivaryBoys;
  const DelivaryState({
    required this.loading,
    required this.failure,
    required this.delivaryBoys,
  });

  DelivaryState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<DelivaryBoy>? delivaryBoys,
  }) {
    return DelivaryState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      delivaryBoys: delivaryBoys ?? this.delivaryBoys,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, delivaryBoys];
  factory DelivaryState.init() => DelivaryState(
      loading: false, failure: CleanFailure.none(), delivaryBoys: const []);
}
