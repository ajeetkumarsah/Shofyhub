// import 'package:clean_api/clean_api.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:alpesportif_seller/application/app/stocks/inventories/inventory_details_state.dart';
// import 'package:alpesportif_seller/domain/app/stocks/inventories/i_inventories_repo.dart';
// import 'package:alpesportif_seller/infrastructure/app/stocks/inventories/inventories_repo.dart';

// final inventoryDetailsProvider = StateNotifierProvider.family
//     .autoDispose<InventoryDetailsNotifier, InventoryDetailsState, int>(
//         (ref, id) {
//   return InventoryDetailsNotifier(InventoriesRepo(), id);
// });

// class InventoryDetailsNotifier extends StateNotifier<InventoryDetailsState> {
//   final int id;
//   final IInventoriesRepo inventoryRepo;
//   InventoryDetailsNotifier(this.inventoryRepo, this.id)
//       : super(InventoryDetailsState.init());
//   inventoryDetails() async {
//     state = state.copyWith(loading: true);
//     final inventoryDetailsData =
//         await inventoryRepo.inventoryDetails(inventoryId: id);
//     state = inventoryDetailsData.fold(
//       (l) {
//         return state.copyWith(failure: l, loading: false);
//       },
//       (r) => state.copyWith(
//           loading: false, failure: CleanFailure.none(), inventoryDetails: r),
//     );
//   }
// }
