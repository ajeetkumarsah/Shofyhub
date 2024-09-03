import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:alpesportif_seller/domain/app/catalog/atributes/atributes_model.dart';

class AtributesState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<AtributesModel> atributes;
  final List<AtributesModel> trashAtributes;
  const AtributesState({
    required this.loading,
    required this.failure,
    required this.atributes,
    required this.trashAtributes,
  });

  AtributesState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<AtributesModel>? atributes,
    List<AtributesModel>? trashAtributes,
  }) {
    return AtributesState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      atributes: atributes ?? this.atributes,
      trashAtributes: trashAtributes ?? this.trashAtributes,
    );
  }

  @override
  String toString() =>
      'AtributesState(loading: $loading, failure: $failure, atributes: $atributes, trashAtributes: $trashAtributes)';

  @override
  List<Object> get props => [loading, failure, atributes, trashAtributes];

  factory AtributesState.init() => AtributesState(
        loading: false,
        failure: CleanFailure.none(),
        atributes: const [],
        trashAtributes: const [],
      );
}
