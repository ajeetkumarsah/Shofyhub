import 'dart:developer';

import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_state.dart';
import 'package:zcart_seller/domain/app/category/category%20group/create_category_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20group/i_category_group_repo.dart';
import 'package:zcart_seller/infrastructure/app/category_management/category%20group/category_group_repo.dart';

final categoryGroupProvider =
    StateNotifierProvider<CategoryGroupNotifier, CategoryGroupState>((ref) {
  return CategoryGroupNotifier(CategoryGroupRepo());
});

class CategoryGroupNotifier extends StateNotifier<CategoryGroupState> {
  final ICategoryGroupRepo categoryGroupRepo;
  CategoryGroupNotifier(this.categoryGroupRepo)
      : super(CategoryGroupState.init());

  getAllCategoryGroup() async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.getAllCategoryGroup();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            allCategoryGroups: r));
  }

  createCategoryGroup(CreateCategoryGroupModel categoryGroupModel) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.createCategoryGroup(
        categoryGroupModel: categoryGroupModel);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
              loading: false,
              failure: CleanFailure.none(),
            ));
    getAllCategoryGroup();
  }

  detailsCategoryGroup({required int categoryGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.detailsCategoryGroup(
        categoryGroupId: categoryGroupId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
              loading: false,
              failure: CleanFailure.none(),
              categoryDetails: r,
            ));
    Logger.i(state.categoryDetails);
  }

  updateCategoryGroup(
      {required int categoryGroupId,
      required String name,
      required String slug,
      required String description,
      required String metaTitle,
      required String metaDescription,
      required int order,
      required String icon,
      required int active}) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.updateCategoryGroup(
      categoryGroupId: categoryGroupId,
      name: name,
      slug: slug,
      description: description,
      metaTitle: metaTitle,
      metaDescription: metaDescription,
      order: order,
      icon: icon,
      active: active,
    );
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAllCategoryGroup();
  }

  trashCategoryGroup({required int categoryGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.trashCategoryGroup(
        categoryGroupId: categoryGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAllCategoryGroup();
  }

  restoreCategoryGroup({required int categoryGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.restoreCategoryGroup(
        categoryGroupId: categoryGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAllCategoryGroup();
  }

  deleteCategoryGroup({required int categoryGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.deleteCategoryGroup(
        categoryGroupId: categoryGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAllCategoryGroup();
  }
}
