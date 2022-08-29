// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_vendor/domain/app/category/category%20sub%20group/category_sub_group_model.dart';

class CategorySubGroupState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<CategorySubGroupModel> categorySubGroup;
  const CategorySubGroupState({
    required this.loading,
    required this.failure,
    required this.categorySubGroup,
  });

  CategorySubGroupState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<CategorySubGroupModel>? categorySubGroup,
  }) {
    return CategorySubGroupState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      categorySubGroup: categorySubGroup ?? this.categorySubGroup,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, categorySubGroup];
  factory CategorySubGroupState.init() => CategorySubGroupState(
      loading: false, failure: CleanFailure.none(), categorySubGroup: const []);
}
