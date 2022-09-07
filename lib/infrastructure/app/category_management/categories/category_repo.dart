import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/category/categories/category_details_model.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';
import 'package:zcart_seller/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_seller/domain/app/category/categories/i_category_repo.dart';

import 'package:zcart_seller/domain/app/category/categories/update_category_model.dart';

class CategoryRepo extends ICategoryRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<CategoryModel>>> getAllCatetories(
      {required int id}) async {
    return cleanApi.get(
        fromData: ((json) => List<CategoryModel>.from(
            json['data'].map((e) => CategoryModel.fromMap(e)))),
        endPoint: 'categories?sub_group_id=$id');
  }

  @override
  Future<Either<CleanFailure, Unit>> createNewCategory(
      {required CreateCategoryModel categoryModel}) async {
    return await cleanApi.post(
        fromData: (josn) => unit, body: null, endPoint: categoryModel.endpoint);
  }

  @override
  Future<Either<CleanFailure, Unit>> updateCategory(
      {required UpdateCategoryModel updateCategoryModel}) async {
    return await cleanApi.put(
        fromData: (josn) => unit,
        body: null,
        endPoint: updateCategoryModel.endpoint);
  }

  @override
  Future<Either<CleanFailure, CategoryModel>> showCatetory(
      {required CategoryModel categoryId}) async {
    return cleanApi.get(
        fromData: (json) => CategoryModel.fromMap(json),
        endPoint: 'category/$categoryId/all');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashCategory(
      {required int categoryId}) async {
    return cleanApi.delete(
        fromData: (json) => unit, endPoint: 'category/$categoryId/trash');
  }

  @override
  Future<Either<CleanFailure, CategoryModel>> restoreCatetory(
      {required CategoryModel categoryId}) async {
    return cleanApi.get(
        fromData: (json) => CategoryModel.fromMap(json),
        endPoint: 'category/$categoryId/all');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteCategory(
      {required int categoryId}) async {
    return cleanApi.delete(
        fromData: (json) => unit, endPoint: 'category/$categoryId/delete');
  }

  @override
  Future<Either<CleanFailure, CategoryDetailsModel>> detailsCategory(
      {required int categoryId}) {
    return cleanApi.get(
        fromData: (json) => CategoryDetailsModel.fromMap(json['data']),
        endPoint: 'category/$categoryId');
  }
}
