import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/i_inventories_repo.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventories_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventory_details_model/inventory_details_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/quick_update_model.dart';

class InventoriesRepo extends IInventoriesRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<InventoriesModel>>> getAllInventories(
      {required String inventoryFilter}) async {
    return cleanApi.get(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'inventory', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'inventory',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'inventory',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'inventory', error: responseBody.toString()));
          }
        },
        fromData: ((json) => List<InventoriesModel>.from(
            json['data'].map((e) => InventoriesModel.fromMap(e)))),
        endPoint: 'inventories?filter=$inventoryFilter');
  }

  @override
  Future<Either<CleanFailure, InventoryDetailsModel>> inventoryDetails(
      {required int inventoryId}) async {
    return cleanApi.get(
      failureHandler:
          <Unit>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'inventory', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'inventory',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'inventory',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'inventory', error: responseBody.toString()));
        }
      },
      fromData: (json) => InventoryDetailsModel.fromMap(json["data"]),
      endPoint: 'inventory/$inventoryId',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> quickUpdate(
      {required QuickUpdateModel quickUpdateModel, required int id}) async {
    return await cleanApi.put(
      failureHandler:
          <Unit>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'inventory', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'inventory',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'inventory',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'inventory', error: responseBody.toString()));
        }
      },
      fromData: (josn) => unit,
      body: null,
      endPoint:
          'inventory/$id/quick_update?title=${quickUpdateModel.title}&stock_quantity=${quickUpdateModel.quantity}&sale_price=${quickUpdateModel.salePrice}&active=${quickUpdateModel.active}',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> moveToTrash({required inventoryId}) {
    return cleanApi.delete(
      failureHandler:
          <Unit>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'inventory', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'inventory',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'inventory',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'inventory', error: responseBody.toString()));
        }
      },
      fromData: (json) => unit,
      endPoint: 'inventory/$inventoryId/trash',
    );
  }
}
