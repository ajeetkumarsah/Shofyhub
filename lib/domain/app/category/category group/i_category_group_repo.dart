import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/category/category%20group/category_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20group/category_group_show_model.dart';

import 'create_category_group_model.dart';

abstract class ICategoryGroupRepo {
  Future<Either<CleanFailure, List<CategoryGroupModel>>> getAllCategoryGroup();
  Future<Either<CleanFailure, List<CategoryGroupModel>>>
      getTrashCategoryGroup();

  Future<Either<CleanFailure, String>> createCategoryGroup(formData);

  Future<Either<CleanFailure, CategoryGroupDetailsModel>> getCategoryGroupById(
      {required int id});

  Future<Either<CleanFailure, CategoryGroupDetailsModel>> detailsCategoryGroup(
      {required int categoryGroupId});

  Future<Either<CleanFailure, String>> updateCategoryGroup(
      {required int categoryGroupId, required formData});

  Future<Either<CleanFailure, Unit>> trashCategoryGroup(
      {required int categoryGroupId});

  Future<Either<CleanFailure, Unit>> restoreCategoryGroup(
      {required int categoryGroupId});

  Future<Either<CleanFailure, Unit>> deleteCategoryGroup(
      {required int categoryGroupId});
}
