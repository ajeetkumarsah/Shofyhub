// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_vendor/domain/app/category/category%20group/category_group_model.dart';

class CategoryGroupFamilyState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final CategoryGroupModel categoryGroupDetails;
  CategoryGroupFamilyState({
    required this.loading,
    required this.failure,
    required this.categoryGroupDetails,
  });

  CategoryGroupFamilyState copyWith({
    bool? loading,
    CleanFailure? failure,
    CategoryGroupModel? categoryGroupDetails,
  }) {
    return CategoryGroupFamilyState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      categoryGroupDetails: categoryGroupDetails ?? this.categoryGroupDetails,
    );
  }

  @override
  String toString() =>
      'CategoryGroupFamilyState(loading: $loading, failure: $failure, categoryGroupDetails: $categoryGroupDetails)';

  @override
  List<Object> get props => [loading, failure, categoryGroupDetails];

  factory CategoryGroupFamilyState.init() => CategoryGroupFamilyState(
      loading: false,
      failure: CleanFailure.none(),
      categoryGroupDetails: CategoryGroupModel.init());
}
