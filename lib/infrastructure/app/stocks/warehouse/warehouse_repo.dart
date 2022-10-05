import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/i_warehouse_repo.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_model.dart';
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
}
