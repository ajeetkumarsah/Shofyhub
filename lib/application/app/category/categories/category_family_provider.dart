import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/domain/app/category/categories/i_category_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/category_management/categories/category_repo.dart';

import 'category_family_state.dart';

final categoryFamilyProvider = StateNotifierProvider.family<
    CategoryFamilyNotifier, CategoryFamilyState, int>((ref, id) {
  return CategoryFamilyNotifier(CategoryRepo(), id);
});

class CategoryFamilyNotifier extends StateNotifier<CategoryFamilyState> {
  final int id;
  final ICategoryRepo categoryRepo;
  CategoryFamilyNotifier(this.categoryRepo, this.id)
      : super(CategoryFamilyState.init());

  getCategoryGroupDetails() async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.detailsCategory(categoryId: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), categoryDetails: r));
  }
}
