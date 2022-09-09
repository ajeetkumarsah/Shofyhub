import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventories_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventory_details_model/inventory_details_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/quick_update_model.dart';

abstract class IInventoriesRepo {
  Future<Either<CleanFailure, List<InventoriesModel>>> getAllInventories(
      {required String inventoryFilter});

  Future<Either<CleanFailure, InventoryDetailsModel>> inventoryDetails(
      {required int inventoryId});

  Future<Either<CleanFailure, Unit>> quickUpdate(
      {required QuickUpdateModel quickUpdateModel, required int id});
  Future<Either<CleanFailure, Unit>> moveToTrash({required inventoryId});
}
