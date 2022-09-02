import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/category/categories/category_details_model.dart';

class CategoryFamilyState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final CategoryDetailsModel categoryDetails;
  const CategoryFamilyState({
    required this.loading,
    required this.failure,
    required this.categoryDetails,
  });

  CategoryFamilyState copyWith({
    bool? loading,
    CleanFailure? failure,
    CategoryDetailsModel? categoryDetails,
  }) {
    return CategoryFamilyState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      categoryDetails: categoryDetails ?? this.categoryDetails,
    );
  }

  @override
  String toString() =>
      'CategoryGroupFamilyState(loading: $loading, failure: $failure, categoryGroupDetails: $categoryDetails)';

  @override
  List<Object> get props => [loading, failure, categoryDetails];

  factory CategoryFamilyState.init() => CategoryFamilyState(
      loading: false,
      failure: CleanFailure.none(),
      categoryDetails: CategoryDetailsModel.init());
}
