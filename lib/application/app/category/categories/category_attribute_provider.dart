import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/category/categories/category_attribute_state.dart';
import 'package:zcart_vendor/domain/app/category/categories/i_category_repo.dart';
import 'package:zcart_vendor/infrastructure/app/category%20management/categories/category_repo.dart';

final categoryAttributeProvider =
    StateNotifierProvider<CategoryAttributeNotifier, CategoryAttributeState>(
        (ref) {
  return CategoryAttributeNotifier(CategoryRepo());
});

class CategoryAttributeNotifier extends StateNotifier<CategoryAttributeState> {
  final ICategoryRepo categoryRepo;
  CategoryAttributeNotifier(this.categoryRepo)
      : super(CategoryAttributeState.init());

  getAttribuits() async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.getAttributes();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), attributeList: r));
  }
}
