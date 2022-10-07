import 'package:clean_api/clean_api.dart';
import 'package:fpdart/src/unit.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/i_supplier_repo.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_pagination_model.dart';

class SupplierRepo extends ISupplierRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, SupplierPaginationModel>> getSuppliers(
      {required int page}) {
    return cleanApi.get(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
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
        endPoint: 'suppliers?page=$page');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashSupplier({required int supplierId}) {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
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
}
