import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventory_details_model/inventory_details_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventory_pagination_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/quick_update_model.dart';

abstract class IInventoriesRepo {
  Future<Either<CleanFailure, InventoryPaginationModel>> getAllInventories(
      {required String inventoryFilter, required int page});

  Future<Either<CleanFailure, InventoryDetailsModel>> inventoryDetails(
      {required int inventoryId});

  Future<Either<CleanFailure, Unit>> quickUpdate(
      {required QuickUpdateModel quickUpdateModel, required int id});
  Future<Either<CleanFailure, Unit>> moveToTrash({required inventoryId});
  Future<Either<CleanFailure, Unit>> restoreInventory({required inventoryId});
  Future<Either<CleanFailure, Unit>> deleteInventory({required inventoryId});
}
