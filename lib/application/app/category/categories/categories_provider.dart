import 'dart:developer';

import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/categories/categories_state.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';
import 'package:zcart_seller/domain/app/category/categories/category_pagination_model.dart';
import 'package:zcart_seller/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_seller/domain/app/category/categories/i_category_repo.dart';

import 'package:zcart_seller/domain/app/category/categories/update_category_model.dart';
import 'package:zcart_seller/infrastructure/app/category_management/categories/category_repo.dart';

final categoryProvider =
    StateNotifierProvider.family<CategoryNotifier, CategoryState, int>(
        (ref, categorySubGroupId) {
  return CategoryNotifier(CategoryRepo(), categorySubGroupId);
});

class CategoryNotifier extends StateNotifier<CategoryState> {
  final int categorySubGroupId;
  final ICategoryRepo categoryRepo;
  CategoryNotifier(this.categoryRepo, this.categorySubGroupId)
      : super(CategoryState.init());

  CategoryPaginationModel categoryPaginationModel =
      CategoryPaginationModel.init();
  List<CategoryModel> categories = [];
  int pageNumber = 1;

  getAllCategories() async {
    state = state.copyWith(loading: true);
    pageNumber = 1;
    categories = [];

    final data = await categoryRepo.getAllCatetories(
        id: categorySubGroupId, page: pageNumber);

    //increase the page no
    pageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      categoryPaginationModel = r;
      categories.addAll(r.data);

      return state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
        allCategoris: categories,
      );
    });
  }

  getMoreCategories() async {
    state = state.copyWith(paginationLoading: true);
    if (pageNumber == 1 ||
        pageNumber <= categoryPaginationModel.meta.lastPage!) {
      final data = await categoryRepo.getAllCatetories(
          id: categorySubGroupId, page: pageNumber);

      pageNumber++;

      state = data.fold(
          (l) => state.copyWith(paginationLoading: false, failure: l), (r) {
        categories.addAll(r.data);

        return state.copyWith(
          loading: false,
          failure: CleanFailure.none(),
          allCategoris: categories,
        );
      });
      state = state;
    }
  }

  createNewCategory(CreateCategoryModel categoryModel) async {
    state = state.copyWith(loading: true);
    final data =
        await categoryRepo.createNewCategory(categoryModel: categoryModel);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllCategories();
  }

  deleteCategory(int categoryId) async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.deleteCategory(categoryId: categoryId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllCategories();
  }

  trashcategory(int categoryId) async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.trashCategory(categoryId: categoryId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllCategories();
  }

  updateCategory(UpdateCategoryModel updatecategoryModel) async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.updateCategory(
        updateCategoryModel: updatecategoryModel);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllCategories();
  }
}
