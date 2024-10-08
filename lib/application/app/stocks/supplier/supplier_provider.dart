import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/stocks/supplier/supplier_state.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/create_supplier_model.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/i_supplier_repo.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/supplier_model.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/supplier_pagination_model.dart';
import 'package:alpesportif_seller/infrastructure/app/stocks/supplier/supplier_repo.dart';

final supplierProvider =
    StateNotifierProvider<SupplierNotifier, SupplierState>((ref) {
  return SupplierNotifier(SupplierRepo());
});

class SupplierNotifier extends StateNotifier<SupplierState> {
  final ISupplierRepo supplierRepo;

  SupplierNotifier(this.supplierRepo) : super(SupplierState.init());

  SupplierPaginationModel supplierPaginationModel =
      SupplierPaginationModel.init();
  SupplierPaginationModel trashSupplierPaginationModel =
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

    final suppliersData = await supplierRepo.getSuppliers(
        supplierFilter: 'trash', page: trashPageNumber);

    //increase the page no
    trashPageNumber++;

    state = suppliersData
        .fold((l) => state.copyWith(loading: false, failure: l), (r) {
      trashSupplierPaginationModel = r;
      trashSuppliers.addAll(trashSupplierPaginationModel.data);

      return state.copyWith(
          loading: false,
          failure: CleanFailure.none(),
          trashSupplier: trashSuppliers);
    });
  }

  getMoreTrashSuppliers() async {
    if (trashPageNumber == 1 ||
        trashPageNumber <= supplierPaginationModel.meta.lastPage!) {
      final data = await supplierRepo.getSuppliers(
          supplierFilter: 'trash', page: trashPageNumber);

      //increase the page no
      trashPageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        trashSupplierPaginationModel = r;
        trashSuppliers.addAll(trashSupplierPaginationModel.data);

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
    getTrashSuppliers();
  }

  createNewSupplier({required CreateSupplierModel supplierInfo}) async {
    state = state.copyWith(loading: true);
    final data = await supplierRepo.createSuppliers(supplierInfo);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllSuppliers();
  }

  updateSupplier(
      {required CreateSupplierModel supplierInfo,
      required int supplierId}) async {
    state = state.copyWith(loading: true);
    final data = await supplierRepo.updateSupplier(
        body: supplierInfo, supplierId: supplierId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getAllSuppliers();
  }

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
