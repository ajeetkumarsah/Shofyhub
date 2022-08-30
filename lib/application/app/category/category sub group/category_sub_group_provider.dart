import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_state.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/create_category_sub_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/i_category_sub_group_repo.dart';
import 'package:zcart_seller/infrastructure/app/category%20management/category%20sub%20group/category_sub_group_repo.dart';

final categorySubGroupProvider = StateNotifierProvider.family
    .autoDispose<CategorySubGroupNotifier, CategorySubGroupState, int>(
        (ref, id) {
  return CategorySubGroupNotifier(id, CategorySubGroupRepo());
});

class CategorySubGroupNotifier extends StateNotifier<CategorySubGroupState> {
  final int id;
  final ICategorySubGroupRepo subGroupRepo;
  CategorySubGroupNotifier(this.id, this.subGroupRepo)
      : super(CategorySubGroupState.init());

  getCategorySubGroup() async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.getCategorySubGroup(categoryGroupId: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), categorySubGroup: r));
    Logger.i(data);
  }

  createCategorySubGroup(
      CreateCategorySubGroupModel createCategorySubGroupModel) async {
    state = state.copyWith(loading: false);
    final data = await subGroupRepo.createCategorySubgroup(
        createCategorySubGroupModel: createCategorySubGroupModel);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
              loading: false,
              failure: CleanFailure.none(),
            ));
    getCategorySubGroup();
  }

  updateCategorySubGroup(
      {required int categorySubGroupId,
      required int successfullyUpdate,
      required String name,
      required String slug,
      required String description,
      required String metaTitle,
      required String metaDescription,
      required bool active,
      required int order}) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.updateCategorySubGroup(
        categorySubGroupId: categorySubGroupId,
        successfullyUpdate: successfullyUpdate,
        name: name,
        slug: slug,
        description: description,
        metaTitle: metaTitle,
        metaDescription: metaDescription,
        active: active,
        order: order);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getCategorySubGroup();
  }

  trashCategorySubGroup({required int categorySubGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.trashCategorySubGroup(
        categorySubGroupId: categorySubGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getCategorySubGroup();
  }

  deleteSubCategoryGroup({required int categorySubGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.deleteCategorySubGroup(
        categorySubGroupId: categorySubGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getCategorySubGroup();
  }

  restoreCategorySubGroup({required int categorySubGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.restoreCategorySubGroup(
        categorySubGroupId: categorySubGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getCategorySubGroup();
  }
}
