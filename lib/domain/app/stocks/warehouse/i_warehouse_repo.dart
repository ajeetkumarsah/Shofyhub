import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_pagination_model.dart';

abstract class IWarehouseRepo {
  Future<Either<CleanFailure, WarehousePaginationModel>> getWarehouseItems(
      {required int page});
  Future<Either<CleanFailure, Unit>> trashWarehouse({required int warehouseId});
}
