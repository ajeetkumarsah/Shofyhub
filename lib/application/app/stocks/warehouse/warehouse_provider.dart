import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_state.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/i_warehouse_repo.dart';
import 'package:zcart_seller/infrastructure/app/stocks/warehouse/warehouse_repo.dart';

final warehouseProvider =
    StateNotifierProvider<WarehouseNotifier, WarehouseState>((ref) {
  return WarehouseNotifier(WarehouseRepo());
});

class WarehouseNotifier extends StateNotifier<WarehouseState> {
  final IWarehouseRepo warehouseRepo;
  WarehouseNotifier(this.warehouseRepo) : super(WarehouseState.init());

  getWarehouseItems() async {
    state = state.copyWith(loading: true);
    final data = await warehouseRepo.getWarehouseItems();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: CleanFailure.none()),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            warehouseItemList: r));
  }
}
