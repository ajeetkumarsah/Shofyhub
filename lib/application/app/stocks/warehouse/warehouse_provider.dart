import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_state.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/create_update_warehouse_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/i_warehouse_repo.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_pagination_model.dart';
import 'package:zcart_seller/infrastructure/app/stocks/warehouse/warehouse_repo.dart';

final warehouseProvider =
    StateNotifierProvider<WarehouseNotifier, WarehouseState>((ref) {
  return WarehouseNotifier(WarehouseRepo());
});

class WarehouseNotifier extends StateNotifier<WarehouseState> {
  final IWarehouseRepo warehouseRepo;
  WarehouseNotifier(this.warehouseRepo) : super(WarehouseState.init());

  WarehousePaginationModel warehousePaginationModel =
      WarehousePaginationModel.init();
  List<WarehouseModel> warehouses = [];
  int pageNumber = 1;

  List<WarehouseModel> trashWarehouses = [];
  int trashPageNumber = 1;

  getWarehouseItems() async {
    pageNumber = 1;
    warehouses = [];

    state = state.copyWith(loading: true);
    final data = await warehouseRepo.getWarehouseItems(
        warehouseFilter: 'null', page: pageNumber);

    //increase the page no
    pageNumber++;

    state = data.fold(
        (l) => state.copyWith(loading: false, failure: CleanFailure.none()),
        (r) {
      warehousePaginationModel = r;
      warehouses.addAll(warehousePaginationModel.data);

      return state.copyWith(
          loading: false,
          failure: CleanFailure.none(),
          warehouseItemList: warehouses);
    });
  }

  getMoreWarehouseItems() async {
    if (pageNumber == 1 ||
        pageNumber <= warehousePaginationModel.meta.lastPage!) {
      final data = await warehouseRepo.getWarehouseItems(
          warehouseFilter: 'null', page: pageNumber);

      //increase the page no
      pageNumber++;

      state = data.fold(
          (l) => state.copyWith(loading: false, failure: CleanFailure.none()),
          (r) {
        warehousePaginationModel = r;
        warehouses.addAll(warehousePaginationModel.data);

        return state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            warehouseItemList: warehouses);
      });
    }
  }

  getTrashWarehouses() async {
    trashPageNumber = 1;
    trashWarehouses = [];

    state = state.copyWith(loading: true);

    //increase the page no
    trashPageNumber++;
    final suppliersData = await warehouseRepo.getWarehouseItems(
        warehouseFilter: 'trash', page: pageNumber);

    state = suppliersData
        .fold((l) => state.copyWith(loading: false, failure: l), (r) {
      // warehousePaginationModel = r;
      trashWarehouses.addAll(r.data);

      return state.copyWith(
          loading: false,
          failure: CleanFailure.none(),
          trashWarehouses: trashWarehouses);
    });
  }

  getMoreTrashWarehouses() async {
    if (trashPageNumber == 1 ||
        trashPageNumber <= warehousePaginationModel.meta.lastPage!) {
      final data = await warehouseRepo.getWarehouseItems(
          warehouseFilter: 'trash', page: trashPageNumber);

      //increase the page no
      trashPageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        warehousePaginationModel = r;
        trashWarehouses.addAll(warehousePaginationModel.data);

        return state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            trashWarehouses: trashWarehouses);
      });
    }
  }

  createWarehouse({required CreateUpdateWarehouseModel warehouseInfo}) async {
    state = state.copyWith(loading: true);
    final data = await warehouseRepo.createWarehouse(warehouseInfo);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getWarehouseItems();
  }

  updateWarehouse(
      {required CreateUpdateWarehouseModel warehouseInfo,
      required int warehouseId}) async {
    state = state.copyWith(loading: true);
    final data = await warehouseRepo.updateWarehouse(
        body: warehouseInfo, warehouseId: warehouseId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getWarehouseItems();
  }

  trashwarehouse(int warehouseId) async {
    state = state.copyWith(loading: true);
    final data = await warehouseRepo.trashWarehouse(warehouseId: warehouseId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getWarehouseItems();
    getTrashWarehouses();
  }

  restoreWarehouse(int warehouseId) async {
    state = state.copyWith(loading: true);
    final data = await warehouseRepo.restoreWarehouse(warehouseId: warehouseId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getWarehouseItems();
    getTrashWarehouses();
  }

  deleteWarehouse(int warehouseId) async {
    state = state.copyWith(loading: true);
    final data = await warehouseRepo.deleteWarehouse(warehouseId: warehouseId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getWarehouseItems();
    getTrashWarehouses();
  }
}
