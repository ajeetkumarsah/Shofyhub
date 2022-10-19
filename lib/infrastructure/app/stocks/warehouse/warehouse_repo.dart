import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/create_update_warehouse_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/i_warehouse_repo.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_details_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_pagination_model.dart';

class WarehouseRepo extends IWarehouseRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, WarehousePaginationModel>> getWarehouseItems(
      {required int page}) async {
    return cleanApi.get(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'warehouse', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'warehouse',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'warehouse',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'warehouse', error: responseBody.toString()));
          }
        },
        fromData: ((json) => WarehousePaginationModel.fromMap(json)),
        endPoint: 'warehouses?page=$page');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashWarehouse(
      {required int warehouseId}) {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'warehouse', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'warehouse',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'warehouse',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'warehouse', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        endPoint: 'warehouse/$warehouseId/trash');
  }

  @override
  Future<Either<CleanFailure, Unit>> createWarehouse(
      CreateUpdateWarehouseModel body) {
    return cleanApi.post(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'warehouse/create?active=${body.active}&address_line_1=${body.addressLine1}&address_line_2=${body.addressLine2}&country_id =${body.countryId}&${body.businessDays}&city=${body.city}&description=${body.description}&email=${body.email}&name=${body.name}&phone=${body.phone}&opening_time=${body.openingTime}&close_time=${body.closeTime}&zip_code=${body.zipCode}&incharge=${body.inchargeId}',
    );
  }

  @override
  Future<Either<CleanFailure, WarehouseDetailsModel>> getWarehouseDetails(
      {required int warehouseId}) {
    return cleanApi.get(
        failureHandler: <SupplierDetailsModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'warehouse', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'warehouse',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'warehouse',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'warehouse', error: responseBody.toString()));
          }
        },
        fromData: ((json) => WarehouseDetailsModel.fromJson(json['data'])),
        endPoint: 'warehouse/$warehouseId');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateWarehouse(
      {required CreateUpdateWarehouseModel body, required warehouseId}) {
    return cleanApi.put(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'warehouse/$warehouseId/update?active=${body.active}&address_line_1=${body.addressLine1}&address_line_2=${body.addressLine2}&country_id =${body.countryId}&${body.businessDays}&city=${body.city}&description=${body.description}&email=${body.email}&name=${body.name}&phone=${body.phone}&opening_time=${body.openingTime}&close_time=${body.closeTime}&zip_code=${body.zipCode}&incharge=${body.inchargeId}',
    );
  }
}
