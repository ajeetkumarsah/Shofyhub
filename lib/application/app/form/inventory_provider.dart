import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/key_value_form_state.dart';
import 'package:zcart_seller/domain/app/form/i_form_repo.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventories_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventory_pagination_model.dart';
import 'package:zcart_seller/infrastructure/app/form/form_repo.dart';

final inventoryProvider =
    StateNotifierProvider.autoDispose<InventoryNotifier, KeyValueFormState>(
        (ref) {
  return InventoryNotifier(repo: FormRepo());
});

class InventoryNotifier extends StateNotifier<KeyValueFormState> {
  final IFormRepo repo;
  InventoryNotifier({required this.repo}) : super(KeyValueFormState.init());

  getInvetoryList() async {
    state = state.copyWith(loading: true);
    final data = await repo.getInvetoryList();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false, dataList: r),
    );
  }
}
