import 'package:clean_api/clean_api.dart';
import 'package:zcart_vendor/domain/app/category/categories/attributes_model.dart';
import 'package:zcart_vendor/domain/app/category/categories/category_model.dart';
import 'package:zcart_vendor/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_vendor/domain/app/category/categories/i_category_repo.dart';
import 'package:zcart_vendor/domain/app/category/categories/update_category.dart';

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
        fromData: (josn) => unit,
        body: null,
        endPoint:
            'category/create?category_sub_group_id=${categoryModel.categorySubGroupId}&name=${categoryModel.name}&slug=${categoryModel.slug}&meta_title=${categoryModel.metaTitle}&meta_description=${categoryModel.metaDescription}&${categoryModel.attributeIds}&active=${categoryModel.active}&order=${categoryModel.order}');
  }

  @override
  Future<Either<CleanFailure, CategoryModel>> showCatetory(
      {required CategoryModel categoryId}) async {
    return cleanApi.get(
        fromData: (json) => CategoryModel.fromMap(json),
        endPoint: 'category/$categoryId/all');
  }

  @override
  Future<Either<CleanFailure, CategoryModel>> trashCatetory(
      {required CategoryModel categoryId}) async {
    return cleanApi.get(
        fromData: (json) => CategoryModel.fromMap(json),
        endPoint: 'category/$categoryId/all');
  }

  @override
  Future<Either<CleanFailure, CategoryModel>> restoreCatetory(
      {required CategoryModel categoryId}) async {
    return cleanApi.get(
        fromData: (json) => CategoryModel.fromMap(json),
        endPoint: 'category/$categoryId/all');
  }

  @override
  Future<Either<CleanFailure, CategoryModel>> deleteCatetory(
      {required CategoryModel categoryId}) async {
    return cleanApi.get(
        fromData: (json) => CategoryModel.fromMap(json),
        endPoint: 'category/$categoryId/all');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateCatetories(
      {required UpdateCategoryModel categoryId}) async {
    return await cleanApi.get(fromData: (json) => unit, endPoint: '');
  }

  @override
  Future<Either<CleanFailure, List<CategoryAttribuitesModel>>>
      getAttributes() async {
    return cleanApi.get(
        fromData: (json) => List<CategoryAttribuitesModel>.from(json
            .map((key, value) =>
                MapEntry(key, CategoryAttribuitesModel(id: key, name: value)))
            .values),
        endPoint: 'data/attributes');
  }
}
