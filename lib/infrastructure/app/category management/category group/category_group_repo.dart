import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/category/category%20group/category_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20group/create_category_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20group/i_category_group_repo.dart';

class CategoryGroupRepo extends ICategoryGroupRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<CategoryGroupModel>>>
      getAllCategoryGroup() async {
    return cleanApi.get(
        fromData: ((json) => List<CategoryGroupModel>.from(
            json['data'].map((e) => CategoryGroupModel.fromMap(e)))),
        endPoint: 'category-groups');
  }

  @override
  Future<Either<CleanFailure, Unit>> createCategoryGroup(
      {required CreateCategoryGroupModel categoryGroupModel}) async {
    return cleanApi.post(
        fromData: (json) => unit,
        body: null,
        endPoint:
            'category/group/create?name=${categoryGroupModel.name}&slug=${categoryGroupModel.slug}&description=${categoryGroupModel.desc}&meta_title=${categoryGroupModel.metaTitle}&meta_description=${categoryGroupModel.meatDesc}');
  }

  @override
  Future<Either<CleanFailure, CategoryGroupModel>> getCategoryGroupById(
      {required int id}) async {
    return cleanApi.get(
        fromData: (json) => CategoryGroupModel.fromMap(json['data']),
        endPoint: 'category/$id');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateCategoryGroup(
      {required int categoryGroupId,
      required String name,
      required String slug,
      required String description,
      required String metaTitle,
      required String metaDescription,
      required int order,
      required String icon,
      required bool active}) async {
    return cleanApi.put(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'category-group/$categoryGroupId/update?name=$name&slug=$slug&description=$description&meta_title=$metaTitle&meta_description=$metaDescription&active=$active&order=$order&icon=$icon&active=$active',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> trashCategoryGroup(
      {required int categoryGroupId}) async {
    return cleanApi.delete(
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-group/$categoryGroupId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreCategoryGroup(
      {required int categoryGroupId}) async {
    return cleanApi.put(
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-group/$categoryGroupId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteCategoryGroup(
      {required int categoryGroupId}) async {
    return cleanApi.delete(
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-group/$categoryGroupId/delete');
  }
}
