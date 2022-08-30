import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_status_state.dart';
import 'package:zcart_seller/domain/app/order/i_order_repo.dart';
import 'package:zcart_seller/infrastructure/app/order/order_repo.dart';

final orderStatusProvider =
    StateNotifierProvider<OrdreStatusNotifier, OrderStatusState>((ref) {
  return OrdreStatusNotifier(OrderRepo());
});

class OrdreStatusNotifier extends StateNotifier<OrderStatusState> {
  final IOrderRepo orderRepo;
  OrdreStatusNotifier(this.orderRepo)
      : super(OrderStatusState(
            loading: false,
            failure: CleanFailure.none(),
            orderStatus: const []));

  getOrderStatus() async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.getOrderStatus();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, failure: CleanFailure.none(), orderStatus: r),
    );
    Logger.i(state.orderStatus);
  }
}
