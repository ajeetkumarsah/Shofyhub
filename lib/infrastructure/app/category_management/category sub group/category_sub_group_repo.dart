import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/category_sub_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/create_category_sub_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/details%20model/category_sub_group_details_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/i_category_sub_group_repo.dart';

class CategorySubGroupRepo extends ICategorySubGroupRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<CategorySubGroupModel>>> getCategorySubGroup(
      {required int categoryGroupId}) async {
    return cleanApi.get(
        failureHandler: <CategorySubGroupModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'category', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'category', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<CategorySubGroupModel>.from(
            json['data'].map((e) => CategorySubGroupModel.fromMap(e)))),
        endPoint: "category-sub-groups?group_id=$categoryGroupId");
  }

  @override
  Future<Either<CleanFailure, Unit>> createCategorySubgroup(
      {required CreateCategorySubGroupModel
          createCategorySubGroupModel}) async {
    return cleanApi.post(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'category', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'category', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint:
            'category-sub-group/create?category_group_id=${createCategorySubGroupModel.categoryGroupId}&name=${createCategorySubGroupModel.name}&slug=${createCategorySubGroupModel.slug}&description=${createCategorySubGroupModel.description}&meta_title=${createCategorySubGroupModel.metaTitle}&meta_description=${createCategorySubGroupModel.metaDescription}&active=${createCategorySubGroupModel.active}&order=${createCategorySubGroupModel.order}');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateCategorySubGroup({
    required int categorySubGroupId,
    required int categoryGroupId,
    required String name,
    required String slug,
    required String description,
    //required String metaTitle,
    //required String metaDescription,
    required bool active,
  }) async {
    return cleanApi.put(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'category', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'category', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint:
            'category-sub-group/$categorySubGroupId/update?category_group_id=$categoryGroupId&name=$name&slug=$slug&description=$description&active=$active'
        //'category-sub-group/$categorySubGroupId/update?category_group_id=$categoryGroupId&name=$name&slug=$slug&description=$description&meta_title=$metaTitle&meta_description=$metaDescription&active=$active&order=$order&images[cover]='
        );
  }

  @override
  Future<Either<CleanFailure, Unit>> trashCategorySubGroup(
      {required int categorySubGroupId}) async {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'category', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'category', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-sub-group/$categorySubGroupId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteCategorySubGroup(
      {required int categorySubGroupId}) async {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'category', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'category', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-sub-group/$categorySubGroupId/delete');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreCategorySubGroup(
      {required int categorySubGroupId}) async {
    return cleanApi.put(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'category', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'category', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'category-sub-group/$categorySubGroupId/restore');
  }

  @override
  Future<Either<CleanFailure, CategorySubGroupDetailsModel>>
      getCategorySubGroupDetails({required int categorySubGroupId}) async {
    return cleanApi.get(
        failureHandler: <CategorySubGroupDetailsModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'category', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'category',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'category', error: responseBody.toString()));
          }
        },
        fromData: (json) => CategorySubGroupDetailsModel.fromMap(json["data"]),
        endPoint: 'category-sub-group/$categorySubGroupId');
  }
}
