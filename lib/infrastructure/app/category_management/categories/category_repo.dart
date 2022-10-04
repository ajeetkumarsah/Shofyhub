import 'dart:developer';

import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/category/categories/category_details_model.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';
import 'package:zcart_seller/domain/app/category/categories/category_pagination_model.dart';
import 'package:zcart_seller/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_seller/domain/app/category/categories/i_category_repo.dart';

import 'package:zcart_seller/domain/app/category/categories/update_category_model.dart';

class CategoryRepo extends ICategoryRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, CategoryPaginationModel>> getAllCatetories(
      {required int id, required int page}) async {
    return cleanApi.get(
        fromData: ((json) => CategoryPaginationModel.fromMap(json)),
        endPoint: 'categories?page=$page&sub_group_id=$id');
  }

  @override
  Future<Either<CleanFailure, Unit>> createNewCategory(
      {required CreateCategoryModel categoryModel}) async {
    return await cleanApi.post(
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
        fromData: (josn) => unit,
        body: null,
        endPoint: categoryModel.endpoint);
  }

  @override
  Future<Either<CleanFailure, Unit>> updateCategory(
      {required UpdateCategoryModel updateCategoryModel}) async {
    return await cleanApi.put(
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
        endPoint: 'category/$categoryId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreCatetory(
      {required CategoryModel categoryId}) async {
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
        endPoint: 'category/$categoryId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteCategory(
      {required int categoryId}) async {
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
        endPoint: 'category/$categoryId/delete');
  }

  @override
  Future<Either<CleanFailure, CategoryDetailsModel>> detailsCategory(
      {required int categoryId}) {
    return cleanApi.get(
        failureHandler: <CategoryDetailsModel>(int statusCode,
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
        fromData: (json) => CategoryDetailsModel.fromMap(json['data']),
        endPoint: 'category/$categoryId');
  }
}
