// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/category/category%20group/category_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20group/category_group_show_model.dart';

class CategoryGroupState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<CategoryGroupModel> allCategoryGroups;
  final CategoryGroupModel categoryGroupId;
  final CategoryGroupDetailsModel categoryDetails;
  const CategoryGroupState({
    required this.loading,
    required this.failure,
    required this.allCategoryGroups,
    required this.categoryGroupId,
    required this.categoryDetails,
  });

  CategoryGroupState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<CategoryGroupModel>? allCategoryGroups,
    CategoryGroupModel? categoryGroupId,
    CategoryGroupDetailsModel? categoryDetails,
  }) {
    return CategoryGroupState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      allCategoryGroups: allCategoryGroups ?? this.allCategoryGroups,
      categoryGroupId: categoryGroupId ?? this.categoryGroupId,
      categoryDetails: categoryDetails ?? this.categoryDetails,
    );
  }

  @override
  String toString() =>
      'CategoryGroupState(loading: $loading, failure: $failure, allCategoryGroups: $allCategoryGroups)';

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      allCategoryGroups,
      categoryGroupId,
      categoryDetails,
    ];
  }

  factory CategoryGroupState.init() => CategoryGroupState(
        loading: false,
        failure: CleanFailure.none(),
        allCategoryGroups: const [],
        categoryGroupId: CategoryGroupModel.init(),
        categoryDetails: CategoryGroupDetailsModel.init(),
      );

  @override
  bool get stringify => true;
}
