import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/application/core/dio_client.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/category_sub_gropu_pagination_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/create_category_sub_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/details%20model/category_sub_group_details_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/i_category_sub_group_repo.dart';

class CategorySubGroupRepo extends ICategorySubGroupRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, CategorySubGropuPaginationModel>>
      getCategorySubGroup(
          {required int categoryGroupId,
          required int page,
          required String filter}) async {
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
        fromData: ((json) => CategorySubGropuPaginationModel.fromMap(json)),
        endPoint:
            "category-sub-groups?group_id=$categoryGroupId&page=$page&filter=$filter");
  }

  @override
  Future<Either<CleanFailure, String>> createCategorySubgroup(formData) async {
    try {
      final response = await DioClient.post(
          url: 'category-sub-group/create', payload: formData);
      return right(response.data['message']);
    } catch (e) {
      return left(CleanFailure(tag: 'category-sub-group', error: e.toString()));
    }
  }

  @override
  Future<Either<CleanFailure, String>> updateCategorySubGroup(
      {required int categorySubGroupId, required formData}) async {
    try {
      final response = await DioClient.post(
          url: 'category-sub-group/$categorySubGroupId/update',
          payload: formData);
      return right(response.data['message']);
    } catch (e) {
      return left(CleanFailure(tag: 'category-sub-group', error: e.toString()));
    }
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
