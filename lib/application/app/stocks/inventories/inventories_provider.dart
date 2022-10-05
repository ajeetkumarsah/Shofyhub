import 'dart:developer';

import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_state.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/i_inventories_repo.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventories_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventory_pagination_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/quick_update_model.dart';
import 'package:zcart_seller/infrastructure/app/stocks/inventories/inventories_repo.dart';

final stockeInventoryProvider =
    StateNotifierProvider<AllInventoriesNotifier, InventoriesState>((ref) {
  return AllInventoriesNotifier(InventoriesRepo());
});

class AllInventoriesNotifier extends StateNotifier<InventoriesState> {
  final IInventoriesRepo inventoryRepo;

  AllInventoriesNotifier(this.inventoryRepo) : super(InventoriesState.init());

  InventoryPaginationModel inventoryPaginationModel =
      InventoryPaginationModel.init();
  List<InventoriesModel> inventories = [];
  int pageNumber = 1;

  getAllInventories({required String inventoryFilter}) async {
    pageNumber = 1;
    inventories = [];

    state = state.copyWith(loading: true);
    final inventoriesData = await inventoryRepo.getAllInventories(
        inventoryFilter: inventoryFilter, page: pageNumber);

    //increase the page no
    pageNumber++;

    state = inventoriesData
        .fold((l) => state.copyWith(loading: false, failure: l), (r) {
      inventoryPaginationModel = r;
      inventories.addAll(inventoryPaginationModel.data);
      return state.copyWith(
          loading: false,
          failure: CleanFailure.none(),
          allInventories: inventories);
    });
  }

  getMoreInventories({required String inventoryFilter}) async {
    if (pageNumber == 1 ||
        pageNumber <= inventoryPaginationModel.meta.lastPage!) {
      final inventoriesData = await inventoryRepo.getAllInventories(
          inventoryFilter: inventoryFilter, page: pageNumber);

      //increase the page no
      pageNumber++;

      state = inventoriesData
          .fold((l) => state.copyWith(loading: false, failure: l), (r) {
        inventoryPaginationModel = r;
        inventories.addAll(inventoryPaginationModel.data);

        return state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            allInventories: inventories);
      });
    }
  }

  getTrashInventories() async {
    state = state.copyWith(loading: true);
    final inventoriesData = await inventoryRepo.getAllInventories(
        inventoryFilter: 'trash', page: 1);
    state = inventoriesData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, failure: CleanFailure.none(), trashInventory: r.data),
    );
  }

  quickUpdate(QuickUpdateModel quickUpdateModel, int id) async {
    state = state.copyWith(loading: true);
    final quickUpdateData = await inventoryRepo.quickUpdate(
        quickUpdateModel: quickUpdateModel, id: id);

    state = quickUpdateData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
      ),
    );
    getAllInventories(inventoryFilter: 'active');
    getTrashInventories();
  }

  trashInventory(int inventoryId) async {
    state = state.copyWith(loading: true);
    final quickUpdateData =
        await inventoryRepo.moveToTrash(inventoryId: inventoryId);

    state = quickUpdateData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
    );
    getAllInventories(inventoryFilter: 'active');
    getTrashInventories();
  }

  restoreInventory(int inventoryId) async {
    state = state.copyWith(loading: true);
    final quickUpdateData =
        await inventoryRepo.restoreInventory(inventoryId: inventoryId);

    state = quickUpdateData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
    );
    getAllInventories(inventoryFilter: 'active');
    getTrashInventories();
  }

  deleteInventory(int inventoryId) async {
    state = state.copyWith(loading: true);
    final quickUpdateData =
        await inventoryRepo.deleteInventory(inventoryId: inventoryId);

    state = quickUpdateData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
    );
    getAllInventories(inventoryFilter: 'active');
    getTrashInventories();
  }
}
