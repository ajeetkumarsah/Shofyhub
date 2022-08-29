import 'package:clean_api/clean_api.dart';
import 'package:zcart_vendor/domain/app/stocks/inventories/i_inventories_repo.dart';
import 'package:zcart_vendor/domain/app/stocks/inventories/inventories_model.dart';
import 'package:zcart_vendor/domain/app/stocks/inventories/inventory_details_model/inventory_details_model.dart';
import 'package:zcart_vendor/domain/app/stocks/inventories/quick_update_model.dart';

class InventoriesRepo extends IInventoriesRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<InventoriesModel>>> getAllInventories(
      {required String inventoryFilter}) async {
    return cleanApi.get(
        fromData: ((json) => List<InventoriesModel>.from(
            json['data'].map((e) => InventoriesModel.fromMap(e)))),
        endPoint: 'inventories?filter=$inventoryFilter');
  }

  @override
  Future<Either<CleanFailure, InventoryDetailsModel>> inventoryDetails(
      {required int inventoryId}) async {
    return cleanApi.get(
      fromData: (json) => InventoryDetailsModel.fromMap(json["data"]),
      endPoint: 'inventory/$inventoryId',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> quickUpdate(
      {required QuickUpdateModel quickUpdateModel, required int id}) async {
    return await cleanApi.put(
      fromData: (josn) => unit,
      body: null,
      endPoint:
          'inventory/$id/quick_update?title=${quickUpdateModel.title}&quantity=${quickUpdateModel.quantity}&sale_price=${quickUpdateModel.salePrice}&active=${quickUpdateModel.active}&expiry_date=${quickUpdateModel.expiryDate}',
    );
  }
}
