import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/category/categories/category_pagination_model.dart';
import 'package:zcart_seller/domain/app/category/categories/create_category_model.dart';

import 'package:zcart_seller/domain/app/category/categories/update_category_model.dart';

import 'category_details_model.dart';
import 'category_model.dart';

abstract class ICategoryRepo {
  Future<Either<CleanFailure, CategoryPaginationModel>> getAllCatetories(
      {required int id, required int page, required String filter});
  Future<Either<CleanFailure, CategoryModel>> showCatetory(
      {required CategoryModel categoryId});

  Future<Either<CleanFailure, Unit>> updateCategory(
      {required UpdateCategoryModel updateCategoryModel});

  // Future<Either<CleanFailure, CategoryModel>> getCategoryById(
  //     {required int id});

  Future<Either<CleanFailure, Unit>> trashCategory({required int categoryId});
  Future<Either<CleanFailure, Unit>> restoreCategory(
      {required int categoryId});
  Future<Either<CleanFailure, CategoryDetailsModel>> detailsCategory(
      {required int categoryId});
  Future<Either<CleanFailure, Unit>> deleteCategory({required int categoryId});

  Future<Either<CleanFailure, Unit>> createNewCategory(
      {required CreateCategoryModel categoryModel});

  editCategory(
      {required int categoryGroupId,
      required String name,
      required String slug,
      required String description,
      required String metaTitle,
      required String metaDescription,
      required int order,
      required String icon,
      required bool active}) {}
}
