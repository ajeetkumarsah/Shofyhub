import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/application/core/dio_client.dart';
import 'package:zcart_seller/domain/app/category/category%20group/category_group_model.dart';
import 'package:zcart_seller/domain/app/category/category%20group/category_group_show_model.dart';
import 'package:zcart_seller/domain/app/category/category%20group/i_category_group_repo.dart';

class CategoryGroupRepo extends ICategoryGroupRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<CategoryGroupModel>>>
      getAllCategoryGroup() async {
    return cleanApi.get(
        failureHandler: <CategoryGroupModel>(int statusCode,
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
        fromData: ((json) => List<CategoryGroupModel>.from(
            json['data'].map((e) => CategoryGroupModel.fromMap(e)))),
        endPoint: 'category-groups?filter=null');
  }

  @override
  Future<Either<CleanFailure, String>> createCategoryGroup(formData) async {
    try {
      final response =
          await DioClient.post(url: '/category-group/create', payload: formData);
      Logger.i('Create Cat Group: ${response.data}');
      return right(response.data['message']);
    } catch (e) {
      return left(CleanFailure(tag: 'category', error: e.toString()));
    }
  }

  @override
  Future<Either<CleanFailure, CategoryGroupDetailsModel>> getCategoryGroupById(
      {required int id}) async {
    return cleanApi.get(
        failureHandler: <CategoryGroupDetailsModel>(int statusCode,
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
        fromData: (json) => CategoryGroupDetailsModel.fromMap(json['data']),
        endPoint: 'category/$id');
  }

  @override
  Future<Either<CleanFailure, String>> updateCategoryGroup(
      {required int categoryGroupId, required formData}) async {
    try {
      final response = await DioClient.post(
          url: '/category-group/$categoryGroupId/update', payload: formData);
      return right(response.data['message']);
    } catch (e) {
      return left(CleanFailure(tag: 'category', error: e.toString()));
    }
  }

  @override
  Future<Either<CleanFailure, Unit>> trashCategoryGroup(
      {required int categoryGroupId}) async {
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
        endPoint: 'category-group/$categoryGroupId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreCategoryGroup(
      {required int categoryGroupId}) async {
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
        endPoint: 'category-group/$categoryGroupId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteCategoryGroup(
      {required int categoryGroupId}) async {
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
        endPoint: 'category-group/$categoryGroupId/delete');
  }

  @override
  Future<Either<CleanFailure, CategoryGroupDetailsModel>> detailsCategoryGroup(
      {required int categoryGroupId}) {
    return cleanApi.get(
        failureHandler: <CategoryGroupDetailsModel>(int statusCode,
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
        fromData: (json) => CategoryGroupDetailsModel.fromMap(json["data"]),
        endPoint: 'category-group/$categoryGroupId');
  }

  @override
  Future<Either<CleanFailure, List<CategoryGroupModel>>>
      getTrashCategoryGroup() async {
    return cleanApi.get(
        failureHandler: <CategoryGroupModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'trash category group', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'trash category group',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'trash category group',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'trash category group', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<CategoryGroupModel>.from(
            json['data'].map((e) => CategoryGroupModel.fromMap(e)))),
        endPoint: 'category-groups?filter=trash');
  }
}
