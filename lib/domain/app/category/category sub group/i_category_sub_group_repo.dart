import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/category/category%20sub%20group/category_sub_gropu_pagination_model.dart';
import 'package:alpesportif_seller/domain/app/category/category%20sub%20group/details%20model/category_sub_group_details_model.dart';

abstract class ICategorySubGroupRepo {
  Future<Either<CleanFailure, CategorySubGroupDetailsModel>>
      getCategorySubGroupDetails({required int categorySubGroupId});

  Future<Either<CleanFailure, CategorySubGropuPaginationModel>>
      getCategorySubGroup(
          {required int categoryGroupId,
          required int page,
          required String filter});

  Future<Either<CleanFailure, String>> createCategorySubgroup(formData);

  Future<Either<CleanFailure, String>> updateCategorySubGroup({
    required int categorySubGroupId,
    required formData,
  });

  Future<Either<CleanFailure, Unit>> trashCategorySubGroup(
      {required int categorySubGroupId});

  Future<Either<CleanFailure, Unit>> restoreCategorySubGroup(
      {required int categorySubGroupId});

  Future<Either<CleanFailure, Unit>> deleteCategorySubGroup(
      {required int categorySubGroupId});
}
