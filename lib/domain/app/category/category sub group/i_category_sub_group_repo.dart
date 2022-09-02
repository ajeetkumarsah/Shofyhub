import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/details%20model/category_sub_group_details_model.dart';

import 'category_sub_group_model.dart';
import 'create_category_sub_group_model.dart';

abstract class ICategorySubGroupRepo {
  Future<Either<CleanFailure, CategorySubGroupDetailsModel>>
      getCategorySubGroupDetails({required int categorySubGroupId});

  Future<Either<CleanFailure, List<CategorySubGroupModel>>> getCategorySubGroup(
      {required int categoryGroupId});

  Future<Either<CleanFailure, Unit>> createCategorySubgroup(
      {required CreateCategorySubGroupModel createCategorySubGroupModel});

  Future<Either<CleanFailure, Unit>> updateCategorySubGroup({
    required int categorySubGroupId,
    required int categoryGroupId,
    required String name,
    required String slug,
    required String description,
    //required String metaTitle,
    //required String metaDescription,
    required bool active,
    //required int order,
    //required String coverImage,
  });

  Future<Either<CleanFailure, Unit>> trashCategorySubGroup(
      {required int categorySubGroupId});

  Future<Either<CleanFailure, Unit>> restoreCategorySubGroup(
      {required int categorySubGroupId});

  Future<Either<CleanFailure, Unit>> deleteCategorySubGroup(
      {required int categorySubGroupId});
}
