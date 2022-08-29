import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/order/order_details_state.dart';
import 'package:zcart_vendor/domain/app/order/i_order_repo.dart';
import 'package:zcart_vendor/infrastructure/app/order/order_repo.dart';

final orderDetailsProvider = StateNotifierProvider.family
    .autoDispose<OrderDetailsNotifier, OrderDetailsState, int>((ref, id) {
  return OrderDetailsNotifier(id, OrderRepo());
});

class OrderDetailsNotifier extends StateNotifier<OrderDetailsState> {
  final int id;
  final IOrderRepo orderRepo;
  OrderDetailsNotifier(this.id, this.orderRepo)
      : super(OrderDetailsState.init());

  getOrderDetails() async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.getOrderDetails(orderId: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), orderDetails: r));
    Logger.i(data);
  }

  markAsPaid() async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.markAsPaid(orderId: id);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getOrderDetails();
  }

  markAsUnpaid() async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.markAsUnpaid(orderId: id);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getOrderDetails();
  }

  updateOrderStatus(int orderStatusId, bool notifyCustomer) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.updateOrderStatus(
        orderId: id,
        orderStatusId: orderStatusId,
        notifyCustomer: notifyCustomer);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getOrderDetails();
  }

  getInvoice() async {
    state = state.copyWith(loading: false);
    final data = await orderRepo.getInvoice(orderId: id);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), invoice: r));
  }
}
