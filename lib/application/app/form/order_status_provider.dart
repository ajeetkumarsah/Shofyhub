import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/domain/app/form/i_form_repo.dart';
import 'package:zcart_seller/infrastructure/app/form/form_repo.dart';

import 'key_value_form_state.dart';

final orderStatusProvider =
    StateNotifierProvider.autoDispose<OrderStatusNotifier, KeyValueFormState>(
        (ref) {
  return OrderStatusNotifier(repo: FormRepo());
});

class OrderStatusNotifier extends StateNotifier<KeyValueFormState> {
  final IFormRepo repo;
  OrderStatusNotifier({required this.repo}) : super(KeyValueFormState.init());

  getOrderStatus() async {
    state = state.copyWith(loading: true);
    final data = await repo.getOrderStatus();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, dataList: r));
  }
}
