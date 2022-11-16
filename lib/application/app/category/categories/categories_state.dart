import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';

class CategoryState extends Equatable {
  final bool loading;
  final bool paginationLoading;
  final CleanFailure failure;
  final List<CategoryModel> allCategoris;
  final List<CategoryModel> trashCategoris;
  const CategoryState({
    required this.loading,
    required this.failure,
    required this.allCategoris,
    required this.trashCategoris,
    required this.paginationLoading,
  });

  CategoryState copyWith({
    bool? loading,
    bool? paginationLoading,
    CleanFailure? failure,
    List<CategoryModel>? allCategoris,
    List<CategoryModel>? trashCategoris,
  }) {
    return CategoryState(
      loading: loading ?? this.loading,
      paginationLoading: paginationLoading ?? this.paginationLoading,
      failure: failure ?? this.failure,
      allCategoris: allCategoris ?? this.allCategoris,
      trashCategoris: trashCategoris ?? this.trashCategoris,
    );
  }

  @override
  String toString() {
    return 'CategorisState(loading: $loading, paginationLoading: $paginationLoading, failure: $failure, allCategoris: $allCategoris, trashCategories: $trashCategoris )';
  }

  @override
  List<Object> get props => [
        loading,
        failure,
        allCategoris,
        trashCategoris,
      ];

  factory CategoryState.init() => CategoryState(
        loading: false,
        paginationLoading: false,
        failure: CleanFailure.none(),
        allCategoris: const [],
        trashCategoris: const [],
      );
}
