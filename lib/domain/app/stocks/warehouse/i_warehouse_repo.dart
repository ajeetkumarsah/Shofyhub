import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/create_update_warehouse_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_details_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_pagination_model.dart';

abstract class IWarehouseRepo {
  Future<Either<CleanFailure, WarehousePaginationModel>> getWarehouseItems(
      {required int page});

  Future<Either<CleanFailure, WarehouseDetailsModel>> getWarehouseDetails(
      {required int warehouseId});
  Future<Either<CleanFailure, Unit>> createWarehouse(
      CreateUpdateWarehouseModel body);
  Future<Either<CleanFailure, Unit>> updateWarehouse(
      {required CreateUpdateWarehouseModel body, required warehouseId});
  Future<Either<CleanFailure, Unit>> trashWarehouse({required int warehouseId});
}
