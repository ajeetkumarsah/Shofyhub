import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';

class CategoryState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final IList<CategoryModel> allCategoris;
  const CategoryState({
    required this.loading,
    required this.failure,
    required this.allCategoris,
  });

  CategoryState copyWith({
    bool? loading,
    CleanFailure? failure,
    IList<CategoryModel>? allCategoris,
  }) {
    return CategoryState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      allCategoris: allCategoris ?? this.allCategoris,
    );
  }

  @override
  String toString() {
    return 'CategorisState(loading: $loading, failure: $failure, allCategoris: $allCategoris, )';
  }

  @override
  List<Object> get props => [loading, failure, allCategoris];

  factory CategoryState.init() => CategoryState(
        loading: false,
        failure: CleanFailure.none(),
        allCategoris: const IListConst([]),
      );
}
