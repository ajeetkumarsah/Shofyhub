// import 'package:clean_api/clean_api.dart';
// import 'package:alpesportif_seller/domain/app/stocks/inventories/i_inventories_repo.dart';
// import 'package:alpesportif_seller/domain/app/stocks/inventories/inventory_details_model/inventory_details_model.dart';
// import 'package:alpesportif_seller/domain/app/stocks/inventories/inventory_pagination_model.dart';
// import 'package:alpesportif_seller/domain/app/stocks/inventories/quick_update_model.dart';
// import 'package:alpesportif_seller/domain/app/stocks/inventories/update_inventory_model.dart';

// class InventoriesRepo extends IInventoriesRepo {
//   final cleanApi = CleanApi.instance;
//   @override
//   Future<Either<CleanFailure, InventoryPaginationModel>> getAllInventories(
//       {required String inventoryFilter, required int page}) async {
//     return cleanApi.get(
//         failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
//           if (responseBody['errors'] != null) {
//             final errors = Map<String, dynamic>.from(responseBody['errors'])
//                 .values
//                 .toList();
//             final error = List.from(errors.first);
//             return left(CleanFailure(tag: 'inventory', error: error.first));
//           } else if (responseBody['message'] != null) {
//             return left(CleanFailure(
//                 tag: 'inventory',
//                 error: responseBody['message'],
//                 statusCode: statusCode));
//           } else if (responseBody['error'] != null) {
//             return left(CleanFailure(
//                 tag: 'inventory',
//                 error: responseBody['error'],
//                 statusCode: statusCode));
//           } else {
//             return left(
//                 CleanFailure(tag: 'inventory', error: responseBody.toString()));
//           }
//         },
//         fromData: ((json) => InventoryPaginationModel.fromMap(json)),
//         endPoint: 'inventories?filter=$inventoryFilter&page=$page');
//   }

//   @override
//   Future<Either<CleanFailure, InventoryDetailsModel>> inventoryDetails(
//       {required int inventoryId}) async {
//     return cleanApi.get(
//       failureHandler: (int statusCode, Map<String, dynamic> responseBody) {


//         if (responseBody['errors'] != null) {
//           final errors =
//               Map<String, dynamic>.from(responseBody['errors']).values.toList();
//           final error = List.from(errors.first);
//           return left(CleanFailure(tag: 'inventory', error: error.first));
//         } else if (responseBody['message'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['message'],
//               statusCode: statusCode));
//         } else if (responseBody['error'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['error'],
//               statusCode: statusCode));
//         } else {
//           return right(InventoryDetailsModel.fromMap(responseBody["data"]));
//         }
//       },
//       fromData: (json) {
//         return InventoryDetailsModel.fromMap(json["data"]);
//       },
//       endPoint: 'inventory/$inventoryId',
//     );
//   }

//   @override
//   Future<Either<CleanFailure, Unit>> quickUpdate(
//       {required QuickUpdateModel quickUpdateModel, required int id}) async {
//     return await cleanApi.put(
//       failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
//         if (responseBody['errors'] != null) {
//           final errors =
//               Map<String, dynamic>.from(responseBody['errors']).values.toList();
//           final error = List.from(errors.first);
//           return left(CleanFailure(tag: 'inventory', error: error.first));
//         } else if (responseBody['message'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['message'],
//               statusCode: statusCode));
//         } else if (responseBody['error'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['error'],
//               statusCode: statusCode));
//         } else {
//           return left(
//               CleanFailure(tag: 'inventory', error: responseBody.toString()));
//         }
//       },
//       fromData: (josn) => unit,
//       body: null,
//       endPoint:
//           'inventory/$id/quick_update?title=${quickUpdateModel.title}&stock_quantity=${quickUpdateModel.quantity}&sale_price=${quickUpdateModel.salePrice}&active=${quickUpdateModel.active}',
//     );
//   }

//   @override
//   Future<Either<CleanFailure, Unit>> moveToTrash({required inventoryId}) {
//     return cleanApi.delete(
//       failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
//         if (responseBody['errors'] != null) {
//           final errors =
//               Map<String, dynamic>.from(responseBody['errors']).values.toList();
//           final error = List.from(errors.first);
//           return left(CleanFailure(tag: 'inventory', error: error.first));
//         } else if (responseBody['message'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['message'],
//               statusCode: statusCode));
//         } else if (responseBody['error'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['error'],
//               statusCode: statusCode));
//         } else {
//           return left(
//               CleanFailure(tag: 'inventory', error: responseBody.toString()));
//         }
//       },
//       fromData: (json) => unit,
//       endPoint: 'inventory/$inventoryId/trash',
//     );
//   }

//   @override
//   Future<Either<CleanFailure, Unit>> deleteInventory({required inventoryId}) {
//     return cleanApi.delete(
//       failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
//         if (responseBody['errors'] != null) {
//           final errors =
//               Map<String, dynamic>.from(responseBody['errors']).values.toList();
//           final error = List.from(errors.first);
//           return left(CleanFailure(tag: 'inventory', error: error.first));
//         } else if (responseBody['message'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['message'],
//               statusCode: statusCode));
//         } else if (responseBody['error'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['error'],
//               statusCode: statusCode));
//         } else {
//           return left(
//               CleanFailure(tag: 'inventory', error: responseBody.toString()));
//         }
//       },
//       fromData: (json) => unit,
//       endPoint: 'inventory/$inventoryId/delete',
//     );
//   }

//   @override
//   Future<Either<CleanFailure, Unit>> restoreInventory({required inventoryId}) {
//     return cleanApi.put(
//       failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
//         if (responseBody['errors'] != null) {
//           final errors =
//               Map<String, dynamic>.from(responseBody['errors']).values.toList();
//           final error = List.from(errors.first);
//           return left(CleanFailure(tag: 'inventory', error: error.first));
//         } else if (responseBody['message'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['message'],
//               statusCode: statusCode));
//         } else if (responseBody['error'] != null) {
//           return left(CleanFailure(
//               tag: 'inventory',
//               error: responseBody['error'],
//               statusCode: statusCode));
//         } else {
//           return left(
//               CleanFailure(tag: 'inventory', error: responseBody.toString()));
//         }
//       },
//       fromData: (json) => unit,
//       body: null,
//       endPoint: 'inventory/$inventoryId/restore',
//     );
//   }

//   @override
//   Future<Either<CleanFailure, Unit>> updateInventory(
//       {required UpdateInventoryModel updateinventory}) {
//     Logger.i('Inventory Endpoint: ${updateinventory.endPoint}');
//     return cleanApi.put(
//         failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
//           if (responseBody['errors'] != null) {
//             final errors = Map<String, dynamic>.from(responseBody['errors'])
//                 .values
//                 .toList();
//             final error = List.from(errors.first);
//             return left(CleanFailure(tag: 'inventories', error: error.first));
//           } else if (responseBody['message'] != null) {
//             return left(CleanFailure(
//                 tag: 'inventories',
//                 error: responseBody['message'],
//                 statusCode: statusCode));
//           } else if (responseBody['error'] != null) {
//             return left(CleanFailure(
//                 tag: 'inventories',
//                 error: responseBody['error'],
//                 statusCode: statusCode));
//           } else {
//             return left(CleanFailure(
//                 tag: 'inventories', error: responseBody.toString()));
//           }
//         },
//         fromData: (json) => unit,
//         body: null,
//         endPoint: updateinventory.endPoint);
//   }
// }
