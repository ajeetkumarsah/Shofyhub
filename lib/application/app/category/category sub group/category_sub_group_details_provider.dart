import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/category/category%20sub%20group/category_sub_group_details_state.dart';
import 'package:alpesportif_seller/domain/app/category/category%20sub%20group/i_category_sub_group_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/category_management/category%20sub%20group/category_sub_group_repo.dart';

final categorySubGroupDetalsProvider = StateNotifierProvider.family.autoDispose<
    CategorySubGroupDetalsNotifier,
    CategorySubGroupDetalsState,
    int>((ref, id) {
  return CategorySubGroupDetalsNotifier(id, CategorySubGroupRepo());
});

class CategorySubGroupDetalsNotifier
    extends StateNotifier<CategorySubGroupDetalsState> {
  final int id;
  final ICategorySubGroupRepo categorySubGroupRepo;
  CategorySubGroupDetalsNotifier(this.id, this.categorySubGroupRepo)
      : super(CategorySubGroupDetalsState.init());

  getCategorySubGroupDetailsData() async {
    state = state.copyWith(loading: true);
    final data = await categorySubGroupRepo.getCategorySubGroupDetails(
        categorySubGroupId: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            categorySubGroupDetails: r));
    Logger.i(data);
  }
}
