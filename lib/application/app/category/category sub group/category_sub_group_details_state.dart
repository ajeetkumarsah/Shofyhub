// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/details%20model/category_sub_group_details_model.dart';

class CategorySubGroupDetalsState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final CategorySubGroupDetailsModel categorySubGroupDetails;
  const CategorySubGroupDetalsState({
    required this.loading,
    required this.failure,
    required this.categorySubGroupDetails,
  });

  CategorySubGroupDetalsState copyWith({
    bool? loading,
    CleanFailure? failure,
    CategorySubGroupDetailsModel? categorySubGroupDetails,
  }) {
    return CategorySubGroupDetalsState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      categorySubGroupDetails:
          categorySubGroupDetails ?? this.categorySubGroupDetails,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, categorySubGroupDetails];

  factory CategorySubGroupDetalsState.init() => CategorySubGroupDetalsState(
      loading: false,
      failure: CleanFailure.none(),
      categorySubGroupDetails: CategorySubGroupDetailsModel.init());
}
