import 'package:clean_api/clean_api.dart';
import 'package:zcart_vendor/domain/app/category/categories/attributes_model.dart';
import 'package:zcart_vendor/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_vendor/domain/app/category/categories/update_category.dart';

import 'category_model.dart';

abstract class ICategoryRepo {
  Future<Either<CleanFailure, List<CategoryModel>>> getAllCatetories(
      {required int id});
  Future<Either<CleanFailure, List<CategoryAttribuitesModel>>> getAttributes();
  Future<Either<CleanFailure, CategoryModel>> showCatetory(
      {required CategoryModel categoryId});
  Future<Either<CleanFailure, Unit>> updateCatetories(
      {required UpdateCategoryModel categoryId});
  Future<Either<CleanFailure, CategoryModel>> trashCatetory(
      {required CategoryModel categoryId});
  Future<Either<CleanFailure, CategoryModel>> restoreCatetory(
      {required CategoryModel categoryId});
  Future<Either<CleanFailure, CategoryModel>> deleteCatetory(
      {required CategoryModel categoryId});

  Future<Either<CleanFailure, Unit>> createNewCategory(
      {required CreateCategoryModel categoryModel});
}
