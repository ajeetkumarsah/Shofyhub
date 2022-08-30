import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/category/categories/attributes_model.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';

class CategorisState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<CategoryModel> allCategoris;
  final List<CategoryAttribuitesModel> attribuitList;
  const CategorisState({
    required this.loading,
    required this.failure,
    required this.allCategoris,
    required this.attribuitList,
  });

  CategorisState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<CategoryModel>? allCategoris,
    List<CategoryAttribuitesModel>? attribuitList,
  }) {
    return CategorisState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      allCategoris: allCategoris ?? this.allCategoris,
      attribuitList: attribuitList ?? this.attribuitList,
    );
  }

  @override
  String toString() {
    return 'CategorisState(loading: $loading, failure: $failure, allCategoris: $allCategoris, attribuitList: $attribuitList)';
  }

  @override
  List<Object> get props => [loading, failure, allCategoris, attribuitList];

  factory CategorisState.init() => CategorisState(
        attribuitList: const [],
        loading: false,
        failure: CleanFailure.none(),
        allCategoris: const [],
      );
}
