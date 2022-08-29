import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_vendor/domain/app/category/categories/attributes_model.dart';

class CategoryAttributeState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<CategoryAttribuitesModel> attributeList;
  const CategoryAttributeState({
    required this.loading,
    required this.failure,
    required this.attributeList,
  });

  factory CategoryAttributeState.init() => CategoryAttributeState(
      loading: false, failure: CleanFailure.none(), attributeList: const []);

  CategoryAttributeState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<CategoryAttribuitesModel>? attributeList,
  }) {
    return CategoryAttributeState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      attributeList: attributeList ?? this.attributeList,
    );
  }

  @override
  String toString() =>
      'CategoryAttributeState(loading: $loading, failure: $failure, attributeList: $attributeList)';

  @override
  List<Object> get props => [loading, failure, attributeList];
}
