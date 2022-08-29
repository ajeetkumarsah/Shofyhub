import 'package:clean_api/clean_api.dart';

import 'category_sub_group_model.dart';
import 'create_category_sub_group_model.dart';

abstract class ICategorySubGroupRepo {
  Future<Either<CleanFailure, List<CategorySubGroupModel>>> getCategorySubGroup(
      {required int categoryGroupId});

  Future<Either<CleanFailure, Unit>> createCategorySubgroup(
      {required CreateCategorySubGroupModel createCategorySubGroupModel});
  Future<Either<CleanFailure, Unit>> updateCategorySubGroup({
    required int categorySubGroupId,
    required int successfullyUpdate,
    required String name,
    required String slug,
    required String description,
    required String metaTitle,
    required String metaDescription,
    required bool active,
    required int order,
    //required String coverImage,
  });

  Future<Either<CleanFailure, Unit>> trashCategorySubGroup(
      {required int categorySubGroupId});

  Future<Either<CleanFailure, Unit>> restoreCategorySubGroup(
      {required int categorySubGroupId});

  Future<Either<CleanFailure, Unit>> deleteCategorySubGroup(
      {required int categorySubGroupId});
}
