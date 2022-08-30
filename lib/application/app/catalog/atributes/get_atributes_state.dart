// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/catalog/atributes/attribute_type_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/categories_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/get_atributes_model.dart/get_atributes_model.dart';

class GetAtributesState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<AttributeTypeModel> attributeType;
  final List<CategoriesModel> categories;
  final GetAtributesModel atributeId;
  const GetAtributesState({
    required this.loading,
    required this.failure,
    required this.attributeType,
    required this.categories,
    required this.atributeId,
  });

  GetAtributesState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<AttributeTypeModel>? attributeType,
    List<CategoriesModel>? categories,
    GetAtributesModel? atributeId,
  }) {
    return GetAtributesState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      attributeType: attributeType ?? this.attributeType,
      categories: categories ?? this.categories,
      atributeId: atributeId ?? this.atributeId,
    );
  }

  @override
  String toString() =>
      'GetAtributesState(loading: $loading, failure: $failure, atributeId: $atributeId)';

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      attributeType,
      categories,
      atributeId,
    ];
  }

  factory GetAtributesState.init() => GetAtributesState(
        loading: false,
        failure: CleanFailure.none(),
        atributeId: GetAtributesModel.init(),
        attributeType: const [],
        categories: const [],
      );

  @override
  bool get stringify => true;
}
