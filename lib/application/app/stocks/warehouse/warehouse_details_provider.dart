import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/stocks/warehouse/warehouse_details_state.dart';
import 'package:alpesportif_seller/domain/app/stocks/warehouse/i_warehouse_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/stocks/warehouse/warehouse_repo.dart';

final warehouseDetailsProvider =
    StateNotifierProvider<WarehouseDetailsNotifier, WarehouseDetailsState>(
        (ref) {
  return WarehouseDetailsNotifier(WarehouseRepo());
});

class WarehouseDetailsNotifier extends StateNotifier<WarehouseDetailsState> {
  final IWarehouseRepo warehouseRepo;

  WarehouseDetailsNotifier(this.warehouseRepo)
      : super(WarehouseDetailsState.init());

  getWarehouseDetails({required int warehouseId}) async {
    state = state.copyWith(loading: true);
    final data =
        await warehouseRepo.getWarehouseDetails(warehouseId: warehouseId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), warehouseDetails: r));
  }
}
