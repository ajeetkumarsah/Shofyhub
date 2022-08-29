import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/category/categories/categories_state.dart';
import 'package:zcart_vendor/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_vendor/domain/app/category/categories/i_category_repo.dart';
import 'package:zcart_vendor/infrastructure/app/category%20management/categories/category_repo.dart';

final categoryProvider =
    StateNotifierProvider.family<CategoriesNotifier, CategorisState, int>(
        (ref, id) {
  return CategoriesNotifier(CategoryRepo(), id);
});

class CategoriesNotifier extends StateNotifier<CategorisState> {
  final int id;
  final ICategoryRepo categoryRepo;
  CategoriesNotifier(this.categoryRepo, this.id) : super(CategorisState.init());

  getAllCategories() async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.getAllCatetories(id: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), allCategoris: r));
  }

  createNewCategory(CreateCategoryModel categoryModel) async {
    state = state.copyWith(loading: true);
    final data =
        await categoryRepo.createNewCategory(categoryModel: categoryModel);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllCategories();
  }
}
