import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/atributes_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/categories_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/attribute_type_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/get_atributes_model.dart/get_atributes_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/i_atributes_repo.dart';

class AtributesRepo extends IAtributesRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<AtributesModel>>> getAtributes() async {
    return cleanApi.get(
      fromData: ((json) => List<AtributesModel>.from(
            json['data'].map(
              (e) => AtributesModel.fromMap(e),
            ),
          )),
      endPoint: 'attributes',
    );
  }

  @override
  Future<Either<CleanFailure, GetAtributesModel>> getAlAtributes(
      {required int attributeId}) async {
    return cleanApi.get(
        fromData: (json) => GetAtributesModel.fromMap(json['data']),
        endPoint: "attribute/$attributeId");
  }

  @override
  Future<Either<CleanFailure, Unit>> createAtributes(
      {required String name,
      required String attributeTypeId,
      required String categoriesIds,
      required String order}) async {
    return cleanApi.post(
      failureHandler:
          <Unit>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'attribute', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'attribute',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'attribute',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'attribute', error: responseBody.toString()));
        }
      },
      fromData: (json) => unit,
      body: null,
      endPoint:
          'attribute/create?name=$name&attribute_type_id=$attributeTypeId&$categoriesIds&order=$order',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> updateAtributes(
      {required attributeId,
      required name,
      required attributeTypeId,
      required categoriesIds,
      required order}) async {
    return cleanApi.put(
      failureHandler:
          <Unit>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'attribute', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'attribute',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'attribute',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'attribute', error: responseBody.toString()));
        }
      },
      fromData: (json) => unit,
      body: null,
      endPoint:
          'attribute/$attributeId/update?name=$name&attribute_type_id=$attributeTypeId&$categoriesIds&order=$order',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> trashAttributes(
      {required int attributeId}) async {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'attribute', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'attribute', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'attribute/$attributeId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreAttributes(
      {required int attributeId}) async {
    return cleanApi.put(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'attribute', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'attribute', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'attribute/$attributeId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteAttributes(
      {required int attributeId}) async {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'attribute', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'attribute', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'attribute/$attributeId/delete');
  }

  @override
  Future<Either<CleanFailure, List<AttributeTypeModel>>>
      getAttributesTypes() async {
    return cleanApi.get(
      fromData: (json) => List<AttributeTypeModel>.from(json
          .map((key, value) =>
              MapEntry(key, AttributeTypeModel(id: key, name: value)))
          .values),
      endPoint: 'data/attribute_types',
    );
  }

  @override
  Future<Either<CleanFailure, List<CategoriesModel>>> getCategories() async {
    return cleanApi.get(
      fromData: (json) => List<CategoriesModel>.from(json
          .map((key, value) =>
              MapEntry(key, CategoriesModel(id: key, name: value)))
          .values),
      endPoint: 'data/categories',
    );
  }
}
