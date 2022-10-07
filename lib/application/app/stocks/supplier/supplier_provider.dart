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

  List<SupplierModel> trashSuppliers = [];
  int trashPageNumber = 1;

  getAllSuppliers() async {
    pageNumber = 1;
    suppliers = [];

    state = state.copyWith(loading: true);
    final inventoriesData = await supplierRepo.getSuppliers(
        supplierFilter: 'null', page: pageNumber);

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
      final inventoriesData = await supplierRepo.getSuppliers(
          supplierFilter: 'null', page: pageNumber);

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

  getTrashSuppliers() async {
    trashPageNumber = 1;
    trashSuppliers = [];

    state = state.copyWith(loading: true);

    //increase the page no
    trashPageNumber++;
    final suppliersData =
        await supplierRepo.getSuppliers(supplierFilter: 'trash', page: 1);

    state = suppliersData
        .fold((l) => state.copyWith(loading: false, failure: l), (r) {
      supplierPaginationModel = r;
      trashSuppliers.addAll(supplierPaginationModel.data);

      return state.copyWith(
          loading: false,
          failure: CleanFailure.none(),
          trashSupplier: trashSuppliers);
    });
  }

  getMoreTrashSuppliers() async {
    if (trashPageNumber == 1 ||
        trashPageNumber <= supplierPaginationModel.meta.lastPage!) {
      final inventoriesData = await supplierRepo.getSuppliers(
          supplierFilter: 'trash', page: trashPageNumber);

      //increase the page no
      trashPageNumber++;

      state = inventoriesData
          .fold((l) => state.copyWith(loading: false, failure: l), (r) {
        supplierPaginationModel = r;
        trashSuppliers.addAll(supplierPaginationModel.data);

        return state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            trashSupplier: trashSuppliers);
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

  restoreSupplier(int supplierId) async {
    state = state.copyWith(loading: true);
    final quickUpdateData =
        await supplierRepo.restoreSupplier(supplierId: supplierId);

    state = quickUpdateData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
    );
    getAllSuppliers();
    getTrashSuppliers();
  }

  deleteSupplier(int supplierId) async {
    state = state.copyWith(loading: true);
    final quickUpdateData =
        await supplierRepo.deleteSupplier(supplierId: supplierId);

    state = quickUpdateData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, failure: CleanFailure.none()),
    );
    getAllSuppliers();
    getTrashSuppliers();
  }
}
