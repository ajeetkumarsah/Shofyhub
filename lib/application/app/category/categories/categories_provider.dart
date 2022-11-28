import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/categories/categories_state.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';
import 'package:zcart_seller/domain/app/category/categories/category_pagination_model.dart';
import 'package:zcart_seller/domain/app/category/categories/i_category_repo.dart';
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

  CategoryPaginationModel trashCategoryPaginationModel =
      CategoryPaginationModel.init();
  List<CategoryModel> trashCategories = [];
  int trashPageNumber = 1;

  getAllCategories() async {
    state = state.copyWith(loading: true);
    pageNumber = 1;
    categories = [];

    final data = await categoryRepo.getAllCatetories(
        id: categorySubGroupId, page: pageNumber, filter: 'null');

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
          id: categorySubGroupId, page: pageNumber, filter: 'null');

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

  getTrashCategories() async {
    state = state.copyWith(loading: true);
    trashPageNumber = 1;
    trashCategories = [];

    final data = await categoryRepo.getAllCatetories(
        id: categorySubGroupId, page: trashPageNumber, filter: 'trash');

    //increase the page no
    trashPageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      trashCategoryPaginationModel = r;
      trashCategories.addAll(r.data);

      return state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
        trashCategoris: trashCategories,
      );
    });
  }

  getMoreTrashCategories() async {
    state = state.copyWith(paginationLoading: true);
    if (trashPageNumber == 1 ||
        trashPageNumber <= trashCategoryPaginationModel.meta.lastPage!) {
      final data = await categoryRepo.getAllCatetories(
          id: categorySubGroupId, page: trashPageNumber, filter: 'trash');

      trashPageNumber++;

      state = data.fold(
          (l) => state.copyWith(paginationLoading: false, failure: l), (r) {
        categories.addAll(r.data);

        return state.copyWith(
          loading: false,
          failure: CleanFailure.none(),
          trashCategoris: categories,
        );
      });
      state = state;
    }
  }

  createNewCategory(formData) async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.createNewCategory(formData);
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
    getTrashCategories();
  }

  restoreCategory(int categoryId) async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.restoreCategory(categoryId: categoryId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllCategories();
    getTrashCategories();
  }

  trashcategory(int categoryId) async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.trashCategory(categoryId: categoryId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllCategories();
    getTrashCategories();
  }

  updateCategory({required formData, required int id}) async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.updateCategory(formData: formData, id: id);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllCategories();
  }
}
