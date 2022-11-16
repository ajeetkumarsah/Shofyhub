import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/category_sub_gropu_pagination_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/details%20model/category_sub_group_details_model.dart';
import 'create_category_sub_group_model.dart';

abstract class ICategorySubGroupRepo {
  Future<Either<CleanFailure, CategorySubGroupDetailsModel>>
      getCategorySubGroupDetails({required int categorySubGroupId});

  Future<Either<CleanFailure, CategorySubGropuPaginationModel>>
      getCategorySubGroup({required int categoryGroupId, required int page, required String filter});

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
    required int active,
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
