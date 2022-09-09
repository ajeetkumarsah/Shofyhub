import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_family_state.dart';
import 'package:zcart_seller/domain/app/category/category%20group/i_category_group_repo.dart';
import 'package:zcart_seller/infrastructure/app/category_management/category%20group/category_group_repo.dart';

final categoryGroupFamilyProvider = StateNotifierProvider.family<
    CategoryGroupFamilyNotifier, CategoryGroupFamilyState, int>((ref, id) {
  return CategoryGroupFamilyNotifier(CategoryGroupRepo(), id);
});

class CategoryGroupFamilyNotifier
    extends StateNotifier<CategoryGroupFamilyState> {
  final int id;
  final ICategoryGroupRepo categoryGroupRepo;
  CategoryGroupFamilyNotifier(this.categoryGroupRepo, this.id)
      : super(CategoryGroupFamilyState.init());

  getCategoryGroupDetails() async {
    state = state.copyWith(loading: true);
    final data =
        await categoryGroupRepo.detailsCategoryGroup(categoryGroupId: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            categoryGroupDetails: r));
  }
}
