import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/catalog/atributes/atributes_model.dart';

class AtributesState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<AtributesModel> atributes;
  const AtributesState({
    required this.loading,
    required this.failure,
    required this.atributes,
  });

  AtributesState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<AtributesModel>? atributes,
  }) {
    return AtributesState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      atributes: atributes ?? this.atributes,
    );
  }

  @override
  String toString() =>
      'AtributesState(loading: $loading, failure: $failure, atributes: $atributes)';

  @override
  List<Object> get props => [loading, failure, atributes];

  factory AtributesState.init() => AtributesState(
        loading: false,
        failure: CleanFailure.none(),
        atributes: const [],
      );
}
