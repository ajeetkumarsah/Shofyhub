import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/application/core/dio_client.dart';
import 'package:alpesportif_seller/domain/app/category/categories/category_details_model.dart';
import 'package:alpesportif_seller/domain/app/category/categories/category_model.dart';
import 'package:alpesportif_seller/domain/app/category/categories/category_pagination_model.dart';
import 'package:alpesportif_seller/domain/app/category/categories/i_category_repo.dart';

class CategoryRepo extends ICategoryRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, CategoryPaginationModel>> getAllCatetories(
      {required int id, required int page, required String filter}) async {
    return cleanApi.get(
        fromData: ((json) => CategoryPaginationModel.fromMap(json)),
        endPoint: 'categories?page=$page&sub_group_id=$id&filter=$filter');
  }

  @override
  Future<Either<CleanFailure, String>> createNewCategory(formData) async {
    try {
      final response =
          await DioClient.post(url: '/category/create', payload: formData);
      return right(response.data['message']);
    } catch (e) {
      return left(CleanFailure(tag: 'category', error: e.toString()));
    }
  }

  @override
  Future<Either<CleanFailure, String>> updateCategory(
      {required formData, required int id}) async {
    try {
      final response =
          await DioClient.post(url: '/category/$id/update', payload: formData);
      return right(response.data['message']);
    } catch (e) {
      return left(CleanFailure(tag: 'category', error: e.toString()));
    }
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
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
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
        endPoint: 'category/$categoryId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreCategory(
      {required int categoryId}) async {
    return cleanApi.put(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
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
        endPoint: 'category/$categoryId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteCategory(
      {required int categoryId}) async {
    return cleanApi.delete(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
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
        endPoint: 'category/$categoryId/delete');
  }

  @override
  Future<Either<CleanFailure, CategoryDetailsModel>> detailsCategory(
      {required int categoryId}) {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
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
        fromData: (json) => CategoryDetailsModel.fromMap(json['data']),
        endPoint: 'category/$categoryId');
  }
}
