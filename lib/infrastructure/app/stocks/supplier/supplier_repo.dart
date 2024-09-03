import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/create_supplier_model.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/i_supplier_repo.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/supplier_details_model.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/supplier_pagination_model.dart';

class SupplierRepo extends ISupplierRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, SupplierPaginationModel>> getSuppliers(
      {required String supplierFilter, required int page}) {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'supplier', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'supplier',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'supplier',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'supplier', error: responseBody.toString()));
          }
        },
        fromData: ((json) => SupplierPaginationModel.fromMap(json)),
        endPoint: 'suppliers?filter=$supplierFilter&page=$page');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashSupplier({required int supplierId}) {
    return cleanApi.delete(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'supplier', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'supplier',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'supplier',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'supplier', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        endPoint: 'supplier/$supplierId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteSupplier({required supplierId}) {
    return cleanApi.delete(
      failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'supplier', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'supplier',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'supplier',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'supplier', error: responseBody.toString()));
        }
      },
      fromData: (json) => unit,
      endPoint: 'supplier/$supplierId/delete',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreSupplier({required supplierId}) {
    return cleanApi.put(
      failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'supplier', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'supplier',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'supplier',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'supplier', error: responseBody.toString()));
        }
      },
      fromData: (json) => unit,
      body: null,
      endPoint: 'supplier/$supplierId/restore',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> createSuppliers(CreateSupplierModel body) {
    return cleanApi.post(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'supplier/create?active=${body.active}&address_line_1=${body.addressLine1}&address_line_2=${body.addressLine2}&country_id=${body.countryId}&contact_person=${body.contactPerson}&city=${body.city}&description=${body.description}&email=${body.email}&name=${body.name}&phone=${body.phone}&url=${body.url}&zip_code=${body.zipCode}',
    );
  }

  @override
  Future<Either<CleanFailure, SupplierDetailsModel>> getSupplierDetails(
      {required int supplierId}) {
    return cleanApi.get(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'supplier', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'supplier',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'supplier',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'supplier', error: responseBody.toString()));
          }
        },
        fromData: ((json) => SupplierDetailsModel.fromJson(json['data'])),
        endPoint: 'supplier/$supplierId');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateSupplier(
      {required CreateSupplierModel body, required supplierId}) {
    return cleanApi.put(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'supplier/$supplierId/update?active=${body.active}&address_line_1=${body.addressLine1}&address_line_2=${body.addressLine2}&country_id=${body.countryId}&contact_person=${body.contactPerson}&city=${body.city}&description=${body.description}&email=${body.email}&name=${body.name}&phone=${body.phone}&url=${body.url}&zip_code=${body.zipCode}',
    );
  }
}
