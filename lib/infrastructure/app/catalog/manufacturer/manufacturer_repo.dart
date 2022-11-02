import 'package:clean_api/clean_api.dart';

import 'package:zcart_seller/domain/app/catalog/manufacturer/i_manufacturer_repo.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_details_model.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_pagination_model.dart';

class ManufacturerRepo extends IManufacturerRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, ManufacturerPaginationModel>> getManufacturerList(
      {required String filter, required int page}) async {
    return cleanApi.get(
        failureHandler: <ManufacturerModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'Manufacturer', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'Manufacturer', error: responseBody.toString()));
          }
        },
        fromData: ((json) => ManufacturerPaginationModel.fromMap(json)),
        endPoint: 'manufacturers?filter=$filter&page=$page');
  }

  @override
  Future<Either<CleanFailure, ManufacturerDetailsModel>> getManufacturerDetails(
      {required int manufacturerId}) async {
    return cleanApi.get(
        failureHandler: <ManufacturerDetailsModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'Manufacturer', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'Manufacturer', error: responseBody.toString()));
          }
        },
        fromData: (json) => ManufacturerDetailsModel.fromMap(json['data']),
        endPoint: 'manufacturer/$manufacturerId');
  }

  @override
  Future<Either<CleanFailure, Unit>> createManufacturer(
      {required String name,
      required String slug,
      required String url,
      required bool active,
      required String countryId,
      required String email,
      required String phone,
      required String description}) async {
    return cleanApi.post(
      failureHandler:
          <Unit>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'Manufacturer', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'Manufacturer',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'Manufacturer',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(CleanFailure(
              tag: 'Manufacturer', error: responseBody.toString()));
        }
      },
      fromData: (json) => unit,
      body: null,
      endPoint:
          'manufacturer/create?name=$name&slug=$slug&active=$active&url=$url&country_id=$countryId&email=$email&phone=$phone&description=$description',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> updateManufacturer(
      {required int manufacturerId,
      required String name,
      required String slug,
      required String url,
      required bool active,
      required String countryId,
      required String email,
      required String phone,
      required String description}) async {
    return cleanApi.put(
      failureHandler:
          <Unit>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'Manufacturer', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'Manufacturer',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'Manufacturer',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(CleanFailure(
              tag: 'Manufacturer', error: responseBody.toString()));
        }
      },
      fromData: (json) => unit,
      body: null,
      endPoint:
          'manufacturer/$manufacturerId/update?name=$name&slug=$slug&active=$active&url=$url&country_id=$countryId&email=$email&phone=$phone&description=$description',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteManufacturer(
      {required int manufacturerId}) async {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'Manufacturer', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'Manufacturer', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        endPoint: 'manufacturer/$manufacturerId/delete');
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreManufacturer(
      {required int manufacturerId}) async {
    return cleanApi.put(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'Manufacturer', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'Manufacturer', error: responseBody.toString()));
          }
        },
        body: null,
        fromData: (json) => unit,
        endPoint: 'manufacturer/$manufacturerId/restore');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashManufacturer(
      {required int manufacturerId}) async {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'Manufacturer', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'Manufacturer',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'Manufacturer', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        endPoint: 'manufacturer/$manufacturerId/trash');
  }
}
