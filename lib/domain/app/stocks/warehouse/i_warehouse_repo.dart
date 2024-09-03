import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/stocks/warehouse/create_update_warehouse_model.dart';
import 'package:alpesportif_seller/domain/app/stocks/warehouse/warehouse_details_model.dart';
import 'package:alpesportif_seller/domain/app/stocks/warehouse/warehouse_pagination_model.dart';

abstract class IWarehouseRepo {
  Future<Either<CleanFailure, WarehousePaginationModel>> getWarehouseItems(
      {required String warehouseFilter, required int page});

  Future<Either<CleanFailure, WarehouseDetailsModel>> getWarehouseDetails(
      {required int warehouseId});
  Future<Either<CleanFailure, Unit>> createWarehouse(
      CreateUpdateWarehouseModel body);
  Future<Either<CleanFailure, Unit>> updateWarehouse(
      {required CreateUpdateWarehouseModel body, required warehouseId});
  Future<Either<CleanFailure, Unit>> trashWarehouse({required int warehouseId});
  Future<Either<CleanFailure, Unit>> restoreWarehouse(
      {required int warehouseId});
  Future<Either<CleanFailure, Unit>> deleteWarehouse(
      {required int warehouseId});
}
