import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/stocks/inventories/inventories_state.dart';
import 'package:zcart_vendor/domain/app/stocks/inventories/i_inventories_repo.dart';
import 'package:zcart_vendor/domain/app/stocks/inventories/quick_update_model.dart';
import 'package:zcart_vendor/infrastructure/app/stocks/inventories/inventories_repo.dart';

final inventoryProvider =
    StateNotifierProvider<AllInventoriesNotifier, InventoriesState>((ref) {
  return AllInventoriesNotifier(InventoriesRepo());
});

class AllInventoriesNotifier extends StateNotifier<InventoriesState> {
  final IInventoriesRepo inventoryRepo;

  AllInventoriesNotifier(this.inventoryRepo) : super(InventoriesState.init());

  getAllInventories({required String inventoryFilter}) async {
    state = state.copyWith(loading: true);
    final inventoriesData =
        await inventoryRepo.getAllInventories(inventoryFilter: inventoryFilter);
    state = inventoriesData.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, failure: CleanFailure.none(), allInventories: r),
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
  }
}
