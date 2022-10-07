import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_state.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/i_supplier_repo.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_model.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_pagination_model.dart';
import 'package:zcart_seller/infrastructure/app/stocks/supplier/supplier_repo.dart';

final supplierProvider =
    StateNotifierProvider<SupplierNotifier, SupplierState>((ref) {
  return SupplierNotifier(SupplierRepo());
});

class SupplierNotifier extends StateNotifier<SupplierState> {
  final ISupplierRepo supplierRepo;

  SupplierNotifier(this.supplierRepo) : super(SupplierState.init());

  SupplierPaginationModel supplierPaginationModel =
      SupplierPaginationModel.init();
  List<SupplierModel> suppliers = [];
  int pageNumber = 1;

  getAllSuppliers() async {
    pageNumber = 1;
    suppliers = [];

    state = state.copyWith(loading: true);
    final inventoriesData = await supplierRepo.getSuppliers(page: pageNumber);

    //increase the page no
    pageNumber++;

    state = inventoriesData
        .fold((l) => state.copyWith(loading: false, failure: l), (r) {
      supplierPaginationModel = r;
      suppliers.addAll(supplierPaginationModel.data);
      return state.copyWith(
          loading: false,
          failure: CleanFailure.none(),
          allSuppliers: suppliers);
    });
  }

  getMoreSuppliers() async {
    if (pageNumber == 1 ||
        pageNumber <= supplierPaginationModel.meta.lastPage!) {
      final inventoriesData = await supplierRepo.getSuppliers(page: pageNumber);

      //increase the page no
      pageNumber++;

      state = inventoriesData
          .fold((l) => state.copyWith(loading: false, failure: l), (r) {
        supplierPaginationModel = r;
        suppliers.addAll(supplierPaginationModel.data);

        return state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            allSuppliers: suppliers);
      });
    }
  }

  trashsupplier(int supplierId) async {
    state = state.copyWith(loading: true);
    final data = await supplierRepo.trashSupplier(supplierId: supplierId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllSuppliers();
  }

  // getTrashInventories() async {
  //   state = state.copyWith(loading: true);
  //   final inventoriesData =
  //       await supplierRepo.getAllInventories(inventoryFilter: 'trash', page: 1);
  //   state = inventoriesData.fold(
  //     (l) => state.copyWith(loading: false, failure: l),
  //     (r) => state.copyWith(
  //         loading: false, failure: CleanFailure.none(), trashInventory: r.data),
  //   );
  // }

  // quickUpdate(QuickUpdateModel quickUpdateModel, int id) async {
  //   state = state.copyWith(loading: true);
  //   final quickUpdateData = await supplierRepo.quickUpdate(
  //       quickUpdateModel: quickUpdateModel, id: id);

  //   state = quickUpdateData.fold(
  //     (l) => state.copyWith(loading: false, failure: l),
  //     (r) => state.copyWith(
  //       loading: false,
  //       failure: CleanFailure.none(),
  //     ),
  //   );
  //   getAllInventories(inventoryFilter: 'active');
  //   getTrashInventories();
  // }

  // updateInventory(UpdateInventoryModel updateInventoryModel) async {
  //   state = state.copyWith(loading: true);
  //   final quickUpdateData = await supplierRepo.updateInventory(
  //       updateinventory: updateInventoryModel);

  //   state = quickUpdateData.fold(
  //     (l) => state.copyWith(loading: false, failure: l),
  //     (r) => state.copyWith(
  //       loading: false,
  //       failure: CleanFailure.none(),
  //     ),
  //   );
  //   getAllInventories(inventoryFilter: 'active');
  //   getTrashInventories();
  // }

  // trashInventory(int inventoryId) async {
  //   state = state.copyWith(loading: true);
  //   final quickUpdateData =
  //       await supplierRepo.moveToTrash(inventoryId: inventoryId);

  //   state = quickUpdateData.fold(
  //     (l) => state.copyWith(loading: false, failure: l),
  //     (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
  //   );
  //   getAllInventories(inventoryFilter: 'active');
  //   getTrashInventories();
  // }

  // restoreInventory(int inventoryId) async {
  //   state = state.copyWith(loading: true);
  //   final quickUpdateData =
  //       await supplierRepo.restoreInventory(inventoryId: inventoryId);

  //   state = quickUpdateData.fold(
  //     (l) => state.copyWith(loading: false, failure: l),
  //     (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
  //   );
  //   getAllInventories(inventoryFilter: 'active');
  //   getTrashInventories();
  // }

  // deleteInventory(int inventoryId) async {
  //   state = state.copyWith(loading: true);
  //   final quickUpdateData =
  //       await supplierRepo.deleteInventory(inventoryId: inventoryId);

  //   state = quickUpdateData.fold(
  //     (l) => state.copyWith(loading: false, failure: l),
  //     (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
  //   );
  //   getAllInventories(inventoryFilter: 'active');
  //   getTrashInventories();
  // }
}
