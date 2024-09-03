import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/category/category%20sub%20group/category_sub_group_state.dart';
import 'package:alpesportif_seller/domain/app/category/category%20sub%20group/category_sub_gropu_pagination_model.dart';
import 'package:alpesportif_seller/domain/app/category/category%20sub%20group/category_sub_group_model.dart';
import 'package:alpesportif_seller/domain/app/category/category%20sub%20group/i_category_sub_group_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/category_management/category%20sub%20group/category_sub_group_repo.dart';

final categorySubGroupProvider = StateNotifierProvider.family<
    CategorySubGroupNotifier, CategorySubGroupState, int>((ref, id) {
  return CategorySubGroupNotifier(id, CategorySubGroupRepo());
});

class CategorySubGroupNotifier extends StateNotifier<CategorySubGroupState> {
  final int id;
  final ICategorySubGroupRepo subGroupRepo;
  CategorySubGroupNotifier(this.id, this.subGroupRepo)
      : super(CategorySubGroupState.init());

  CategorySubGropuPaginationModel categorySubGropuPaginationModel =
      CategorySubGropuPaginationModel.init();
  List<CategorySubGroupModel> items = [];
  int pageNumber = 1;

  CategorySubGropuPaginationModel trashCategorySubGropuPaginationModel =
      CategorySubGropuPaginationModel.init();
  List<CategorySubGroupModel> trashItems = [];
  int trashPageNumber = 1;

  getCategorySubGroup() async {
    pageNumber = 1;
    items = [];

    state = state.copyWith(loading: true);
    final data = await subGroupRepo.getCategorySubGroup(
        categoryGroupId: id, page: pageNumber, filter: 'null');

    //increase the page no
    pageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      categorySubGropuPaginationModel = r;
      items.addAll(categorySubGropuPaginationModel.data);

      return state.copyWith(
        loading: false,
        categorySubGroup: items,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(data);
  }

  getMoreCategorySubGroup() async {
    if (pageNumber == 1 ||
        pageNumber <= categorySubGropuPaginationModel.meta.lastPage!) {
      final data = await subGroupRepo.getCategorySubGroup(
        categoryGroupId: id,
        page: pageNumber,
        filter: 'null',
      );

      //increase the page no
      pageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        categorySubGropuPaginationModel = r;
        items.addAll(categorySubGropuPaginationModel.data);

        return state.copyWith(
          loading: false,
          categorySubGroup: items,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(data);
    }
  }

  createCategorySubGroup(formData) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.createCategorySubgroup(formData);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
              loading: false,
              failure: CleanFailure.none(),
            ));
    getCategorySubGroup();
  }

  updateCategorySubGroup(
      {required int categorySubGroupId, required formData}) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.updateCategorySubGroup(
        categorySubGroupId: categorySubGroupId, formData: formData);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getCategorySubGroup();
  }

  getTrashCategorySubGroup() async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.getCategorySubGroup(
        categoryGroupId: id, page: trashPageNumber, filter: 'trash');

    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
              loading: false,
              categorySubGroupTrash: r.data,
              failure: CleanFailure.none(),
            ));

    Logger.i('trash data ${state.categorySubGroupTrash}');
  }

  // getMoreTrashCategorySubGroup() async {
  //   if (trashPageNumber == 1 ||
  //       trashPageNumber <= categorySubGropuPaginationModel.meta.lastPage!) {
  //     final data = await subGroupRepo.getCategorySubGroup(
  //       categoryGroupId: id,
  //       page: trashPageNumber,
  //       filter: 'trash',
  //     );

  //     //increase the page no
  //     trashPageNumber++;

  //     state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
  //       trashCategorySubGropuPaginationModel = r;
  //       trashItems.addAll(trashCategorySubGropuPaginationModel.data);

  //       return state.copyWith(
  //         loading: false,
  //         categorySubGroupTrash: trashItems,
  //         failure: CleanFailure.none(),
  //       );
  //     });
  //     Logger.i(data);
  //   }
  // }

  trashCategorySubGroup({required int categorySubGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.trashCategorySubGroup(
        categorySubGroupId: categorySubGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      getCategorySubGroup();
      getTrashCategorySubGroup();
      return state.copyWith(loading: false, failure: CleanFailure.none());
    });
    Logger.i(data);
  }

  deleteSubCategoryGroup({required int categorySubGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.deleteCategorySubGroup(
        categorySubGroupId: categorySubGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      getCategorySubGroup();
      getTrashCategorySubGroup();
      return state.copyWith(loading: false, failure: CleanFailure.none());
    });
    Logger.i(data);
  }

  restoreCategorySubGroup({required int categorySubGroupId}) async {
    state = state.copyWith(loading: true);
    final data = await subGroupRepo.restoreCategorySubGroup(
        categorySubGroupId: categorySubGroupId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getCategorySubGroup();
    getTrashCategorySubGroup();
    Logger.i(data);
  }
}
