import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_state.dart';
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

  getTrashCategoryGroup() async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.getTrashCategoryGroup();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            trashCategoryGroups: r));
  }

  createCategoryGroup(formData) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.createCategoryGroup(formData);
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

  updateCategoryGroup({required formData, required int id}) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.updateCategoryGroup(
      categoryGroupId: id,
      formData: formData,
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
    getTrashCategoryGroup();
  }

  restoreCategoryGroup({required int categoryGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.restoreCategoryGroup(
        categoryGroupId: categoryGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAllCategoryGroup();
    getTrashCategoryGroup();
  }

  deleteCategoryGroup({required int categoryGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await categoryGroupRepo.deleteCategoryGroup(
        categoryGroupId: categoryGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getAllCategoryGroup();
    getTrashCategoryGroup();
  }
}
