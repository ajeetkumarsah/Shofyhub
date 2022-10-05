import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_state.dart';
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

  getWarehouseItems() async {
    pageNumber = 1;
    warehouses = [];

    state = state.copyWith(loading: true);
    final data = await warehouseRepo.getWarehouseItems(page: pageNumber);

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
      final data = await warehouseRepo.getWarehouseItems(page: pageNumber);

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

  trashwarehouse(int warehouseId) async {
    state = state.copyWith(loading: true);
    final data = await warehouseRepo.trashWarehouse(warehouseId: warehouseId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getWarehouseItems();
  }
}
