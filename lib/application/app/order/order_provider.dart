import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/order/order_state.dart';
import 'package:alpesportif_seller/domain/app/order/i_order_repo.dart';
import 'package:alpesportif_seller/domain/app/order/order_model.dart';
import 'package:alpesportif_seller/domain/app/order/order_pagination_model.dart';
import 'package:alpesportif_seller/infrastructure/app/order/order_repo.dart';

class OrderFilter {
  OrderFilter._();
  static const String all = 'null';
  static const String unfullfill = 'unfulfilled';
  static const String fullfill = 'fulfilled';
  static const String unpaid = 'unpaid';
  static const String paid = 'paid';
  static const String archived = 'archived';
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier(OrderRepo());
});

class OrderNotifier extends StateNotifier<OrderState> {
  final IOrderRepo orderRepo;
  OrderNotifier(this.orderRepo) : super(OrderState.init());

  OrderPaginationModel orderPaginationModel = OrderPaginationModel.init();
  List<OrderModel> orders = [];
  int pageNumber = 1;

  OrderPaginationModel fulfilledOrderPaginationModel =
      OrderPaginationModel.init();
  List<OrderModel> fullfilledOrders = [];
  int fullfilledOrdersPageNumber = 1;

  OrderPaginationModel unFulfilledOrderPaginationModel =
      OrderPaginationModel.init();
  List<OrderModel> unFullfilledOrders = [];
  int unFullfilledOrdersPageNumber = 1;

  OrderPaginationModel archivedOrderPaginationModel =
      OrderPaginationModel.init();
  List<OrderModel> archivedOrders = [];
  int arhivedOrdersPageNumber = 1;

  getOrders() async {
    pageNumber = 1;
    orders = [];

    state = state.copyWith(loading: true);
    final data =
        await orderRepo.getOrders(filter: OrderFilter.all, page: pageNumber);

    //increase the page no
    pageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      orderPaginationModel = r;
      orders.addAll(orderPaginationModel.data);

      return state.copyWith(
        loading: false,
        orderList: orders,
        orderModel: r,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(state.orderList);
  }

  getMoreOrders() async {
    if (pageNumber == 1 || pageNumber <= orderPaginationModel.meta.lastPage!) {
      final data =
          await orderRepo.getOrders(filter: OrderFilter.all, page: pageNumber);

      //increase the page no
      pageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        orderPaginationModel = r;
        orders.addAll(orderPaginationModel.data);

        return state.copyWith(
          loading: false,
          orderList: orders,
          orderModel: r,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(state.orderList);
    }
  }

  getFullFilledOrders() async {
    fullfilledOrdersPageNumber = 1;
    fullfilledOrders = [];

    state = state.copyWith(loading: true);
    final data = await orderRepo.getOrders(
        filter: OrderFilter.fullfill, page: fullfilledOrdersPageNumber);

    //increase the page no
    fullfilledOrdersPageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      fulfilledOrderPaginationModel = r;
      fullfilledOrders.addAll(fulfilledOrderPaginationModel.data);

      return state.copyWith(
        loading: false,
        fullfillOrderList: fullfilledOrders,
        fulfillOrderModel: r,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(state.fullfillOrderList);
  }

  getMoreFullFilledOrders() async {
    if (fullfilledOrdersPageNumber == 1 ||
        fullfilledOrdersPageNumber <=
            fulfilledOrderPaginationModel.meta.lastPage!) {
      final data = await orderRepo.getOrders(
          filter: OrderFilter.fullfill, page: fullfilledOrdersPageNumber);

      //increase the page no
      fullfilledOrdersPageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        fulfilledOrderPaginationModel = r;
        fullfilledOrders.addAll(fulfilledOrderPaginationModel.data);

        return state.copyWith(
          loading: false,
          fullfillOrderList: fullfilledOrders,
          // fulfillOrderModel: r,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(state.fullfillOrderList);
    }
  }

  getUnFullFilledOrders() async {
    unFullfilledOrders = [];
    unFullfilledOrdersPageNumber = 1;

    state = state.copyWith(loading: true);
    final data = await orderRepo.getOrders(
        filter: OrderFilter.unfullfill, page: unFullfilledOrdersPageNumber);

    //increase the page no
    unFullfilledOrdersPageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      unFulfilledOrderPaginationModel = r;
      unFullfilledOrders.addAll(unFulfilledOrderPaginationModel.data);

      return state.copyWith(
        loading: false,
        unFulfillOrderList: unFullfilledOrders,
        unFulfillOrderModel: r,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(state.unFulfillOrderList);
  }

  getMoreUnFullFilledOrders() async {
    if (unFullfilledOrdersPageNumber == 1 ||
        unFullfilledOrdersPageNumber <=
            unFulfilledOrderPaginationModel.meta.lastPage!) {
      final data = await orderRepo.getOrders(
          filter: OrderFilter.unfullfill, page: unFullfilledOrdersPageNumber);

      //increase the page no
      unFullfilledOrdersPageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        unFulfilledOrderPaginationModel = r;
        unFullfilledOrders.addAll(unFulfilledOrderPaginationModel.data);

        return state.copyWith(
          loading: false,
          unFulfillOrderList: unFullfilledOrders,
          // unFulfillOrderModel: r,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(state.unFulfillOrderList);
    }
  }

  getArchivedOrders() async {
    archivedOrders = [];
    arhivedOrdersPageNumber = 1;

    state = state.copyWith(loading: true);
    final data = await orderRepo.getOrders(
        filter: OrderFilter.archived, page: arhivedOrdersPageNumber);

    //increase the page no
    arhivedOrdersPageNumber++;

    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      archivedOrderPaginationModel = r;
      archivedOrders.addAll(archivedOrderPaginationModel.data);

      return state.copyWith(
        loading: false,
        archivedOrderList: archivedOrders,
        failure: CleanFailure.none(),
      );
    });
    Logger.i(state.archivedOrderList);
  }

  getMoreArchivedOrders() async {
    if (arhivedOrdersPageNumber == 1 ||
        arhivedOrdersPageNumber <= orderPaginationModel.meta.lastPage!) {
      final data = await orderRepo.getOrders(
          filter: OrderFilter.fullfill, page: arhivedOrdersPageNumber);

      //increase the page no
      arhivedOrdersPageNumber++;

      state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
        archivedOrderPaginationModel = r;
        archivedOrders.addAll(archivedOrderPaginationModel.data);

        return state.copyWith(
          loading: false,
          archivedOrderList: archivedOrders,
          failure: CleanFailure.none(),
        );
      });
      Logger.i(state.archivedOrderList);
    }
  }

  assignDelivaryBoy(int orderId, int delivaryBoyId) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.assignDelivaryBoy(
        orderId: orderId, delivaryBoyId: delivaryBoyId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getArchivedOrders();
    getFullFilledOrders();
    getUnFullFilledOrders();
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
    // getOrders();
    getArchivedOrders();
    getFullFilledOrders();
    getUnFullFilledOrders();
  }

  markAsDelivered(int orderId, bool notifyCustomer) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.markAsDelivered(
        orderId: orderId, notifyCustomer: notifyCustomer);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getArchivedOrders();
    getFullFilledOrders();
    getUnFullFilledOrders();
  }

  cancleOrder(int orderId, bool notifyCustomer) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.cancleOrder(
        orderId: orderId, notifyCustomer: notifyCustomer);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    getArchivedOrders();
    getFullFilledOrders();
    getUnFullFilledOrders();
  }

  unarchiveOrder(int orderId) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.unarchiveOrder(orderId: orderId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    // getOrders();
    getArchivedOrders();
  }

  archiveOrder(int orderId, {VoidCallback? reloadList}) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.archiveOrder(orderId: orderId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    // getOrders();
    if (reloadList != null) {
      reloadList();
    }
    getArchivedOrders();
  }

  deleteOrder(int orderId) async {
    state = state.copyWith(loading: true);
    final data = await orderRepo.deleteOrder(orderId: orderId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    Logger.i(data);
    // getOrders();
    getFullFilledOrders();
    getUnFullFilledOrders();
    getArchivedOrders();
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
