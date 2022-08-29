import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/order/order_state.dart';
import 'package:zcart_vendor/domain/app/order/i_order_repo.dart';
import 'package:zcart_vendor/infrastructure/app/order/order_repo.dart';

class OrderFilter {
  OrderFilter._();
  static const String unfullfill = 'unfulfilled';
  static const String unpaid = 'unpaid';
  static const String paid = 'paid';
  static const String archived = 'archived';
}

final orderProvider =
    StateNotifierProvider.family<OrderNotifier, OrderState, String?>(
        (ref, filter) {
  return OrderNotifier(OrderRepo(), filter);
});

class OrderNotifier extends StateNotifier<OrderState> {
  final String? filter;
  final IOrderRepo orderRepo;
  OrderNotifier(this.orderRepo, this.filter) : super(OrderState.init());

  getOrders() async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.getOrders(filter: filter);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), orderList: r));
    Logger.i(state.orderList);
  }

  // getUnfullfilledOrder(dynamic filter) async {
  //   state = state.copyWith(loading: true);
  //   final data = await orderRepo.getOrders(filter: filter);
  //   state = data.fold(
  //       (l) => state.copyWith(loading: false, failure: l),
  //       (r) => state.copyWith(
  //           loading: false,
  //           failure: CleanFailure.none(),
  //           unfullfilledOrderList: r));
  //   Logger.i(state.orderList);
  // }

  // getArchivedOrder() async {
  //   state = state.copyWith(loading: true);
  //   final data = await orderRepo.getArchivedOrder();
  //   state = data.fold(
  //       (l) => state.copyWith(loading: false, failure: l),
  //       (r) => state.copyWith(
  //           loading: false, arcivedOrderList: r, failure: CleanFailure.none()));
  //   Logger.i(state.arcivedOrderList);
  // }

  assignDelivaryBoy(int orderId, int delivaryBoyId) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.assignDelivaryBoy(
        orderId: orderId, delivaryBoyId: delivaryBoyId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
  }

  fulfillOrder(int orderId, int carrierId, String trackingId,
      bool notifyCustomer) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.fulfillOrder(
        orderId: orderId,
        carrierId: carrierId,
        trackingId: trackingId,
        notifyCustomer: notifyCustomer);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getOrders();
  }

  markAsDelivered(int orderId, bool notifyCustomer) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.markAsDelivered(
        orderId: orderId, notifyCustomer: notifyCustomer);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
  }

  cancleOrder(int orderId, bool notifyCustomer) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.cancleOrder(
        orderId: orderId, notifyCustomer: notifyCustomer);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
  }

  unarchiveOrder(int orderId) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.unarchiveOrder(orderId: orderId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getOrders();
  }

  archiveOrder(int orderId) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.archiveOrder(orderId: orderId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getOrders();
  }

  deleteOrder(int orderId) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.deleteOrder(orderId: orderId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getOrders();
  }

  adminNote(int orderId, String adminNote) async {
    state = state.copyWith(loading: true);
    final data =
        await orderRepo.adminNote(orderId: orderId, adminNote: adminNote);
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
      ),
    );
    Logger.i(data);
  }
}
