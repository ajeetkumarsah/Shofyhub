// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_vendor/domain/app/catalog/attribute%20values/attribute_values_model.dart';

class AttributeValuesState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<AttributeValuesModel> attributeValues;
  const AttributeValuesState({
    required this.loading,
    required this.failure,
    required this.attributeValues,
  });

  AttributeValuesState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<AttributeValuesModel>? attributeValues,
  }) {
    return AttributeValuesState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      attributeValues: attributeValues ?? this.attributeValues,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, attributeValues];

  factory AttributeValuesState.init() => AttributeValuesState(
      loading: false, failure: CleanFailure.none(), attributeValues: const []);
}
