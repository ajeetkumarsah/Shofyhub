import 'package:clean_api/clean_api.dart';
import 'package:zcart_vendor/domain/app/category/category%20sub%20group/category_sub_group_model.dart';
import 'package:zcart_vendor/domain/app/category/category%20sub%20group/create_category_sub_group_model.dart';
import 'package:zcart_vendor/domain/app/category/category%20sub%20group/i_category_sub_group_repo.dart';

class CategorySubGroupRepo extends ICategorySubGroupRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<CategorySubGroupModel>>> getCategorySubGroup(
      {required int categoryGroupId}) async {
    return cleanApi.get(
        fromData: ((json) => List<CategorySubGroupModel>.from(
            json['data'].map((e) => CategorySubGroupModel.fromMap(e)))),
        endPoint: "category-sub-groups?group_id=$categoryGroupId");
  }

  @override
  Future<Either<CleanFailure, Unit>> createCategorySubgroup(
      {required CreateCategorySubGroupModel
          createCategorySubGroupModel}) async {
    return cleanApi.post(
        fromData: (json) => unit,
        body: null,
        endPoint:
            'category-sub-group/create?category_group_id=${createCategorySubGroupModel.categoryGroupId}&name=${createCategorySubGroupModel.name}&slug=${createCategorySubGroupModel.slug}&meta_title=${createCategorySubGroupModel.metaTitle}&meta_description=${createCategorySubGroupModel.metaDescription}&active=${createCategorySubGroupModel.active}&order=${createCategorySubGroupModel.order}&images[cover]=');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateCategorySubGroup(
      {required int categorySubGroupId,
      required int successfullyUpdate,
      required String name,
      required String slug,
      required String description,
      required String metaTitle,
      required String metaDescription,
      required bool active,
      required int order}) async {
    return cleanApi.put(
        fromData: (json) => unit,
        body: null,
        endPoint:
            'category-sub-group/$categorySubGroupId/update?category_sub_group_update_successfully=$successfullyUpdate&name=$name&slug=$slug&description=$description&meta_title=$metaTitle&meta_description=$metaDescription&active=$active&order=$order&images[cover]=');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashCategorySubGroup(
      {required int categorySubGroupId}) async {
    return cleanApi.delete(
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-sub-group/$categorySubGroupId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteCategorySubGroup(
      {required int categorySubGroupId}) async {
    return cleanApi.delete(
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-sub-group/$categorySubGroupId/delete');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreCategorySubGroup(
      {required int categorySubGroupId}) async {
    return cleanApi.put(
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-sub-group/$categorySubGroupId/restore');
  }
}
