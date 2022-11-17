import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/catalog/attribute%20values/attribute_value_details_model/attribute_value_details_model.dart';
import 'package:zcart_seller/domain/app/catalog/attribute%20values/attribute_values_model.dart';
import 'package:zcart_seller/domain/app/catalog/attribute%20values/i_attribute_values_repo.dart';

class AttributeValuesRepo extends IAttributeValuesRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<AttributeValuesModel>>> getAttributeValues(
      {required int attributeId, required String filter}) async {
    return cleanApi.get(
        fromData: ((json) => List<AttributeValuesModel>.from(
            json['data'].map((e) => AttributeValuesModel.fromMap(e)))),
        endPoint: 'attribute/$attributeId/values?filter=$filter');
  }

  @override
  Future<Either<CleanFailure, AttributeValueDetailsModel>>
      getAttributeValueDetails({required int attributeValueId}) async {
    return cleanApi.get(
        failureHandler: <AttributeValueDetailsModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'attribute value', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'attribute value', error: responseBody.toString()));
          }
        },
        fromData: (json) => AttributeValueDetailsModel.fromMap(json["data"]),
        endPoint: 'attribute-value/$attributeValueId');
  }

  @override
  Future<Either<CleanFailure, Unit>> createAttributeValue(
      {required String value,
      required int attributeId,
      required String color,
      required int order}) async {
    return cleanApi.post(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'attribute value', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'attribute value', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint:
            'attribute-value/create?value=$value&attribute_id=$attributeId&color=$color&order=$order');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateAttributeValue(
      {required int attributeValueId,
      required String value,
      required String color,
      required int attributeId,
      required int order}) async {
    return cleanApi.put(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'attribute value', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'attribute value', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint:
            'attribute-value/$attributeValueId/update?value=$value&color=$color&attribute_id=$attributeId&order=$order');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashAttributeValue(
      {required int attributeValueId}) async {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'attribute value', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'attribute value', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'attribute-value/$attributeValueId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreAttributeValue(
      {required int attributeValueId}) {
    return cleanApi.put(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'attribute value', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'attribute value', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'attribute-value/$attributeValueId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteAttributeValue(
      {required int attributeValueId}) async {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'attribute value', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'attribute value',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'attribute value', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'attribute-value/$attributeValueId/delete');
  }
}
