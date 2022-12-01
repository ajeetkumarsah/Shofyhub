// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/order/order_model.dart';
import 'package:zcart_seller/domain/app/order/order_pagination_model.dart';
import 'package:zcart_seller/domain/app/order/order_status_model.dart';

class OrderState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<OrderModel> orderList;
  final List<OrderModel> fullfillOrderList;
  final List<OrderModel> unFulfillOrderList;
  final List<OrderModel> archivedOrderList;
  final OrderPaginationModel orderModel;
  final OrderPaginationModel fulfillOrderModel;
  final OrderPaginationModel unFulfillOrderModel;

  const OrderState({
    required this.loading,
    required this.failure,
    required this.orderList,
    required this.fullfillOrderList,
    required this.unFulfillOrderList,
    required this.archivedOrderList,
    required this.orderModel,
    required this.fulfillOrderModel,
    required this.unFulfillOrderModel,
  });

  OrderState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<OrderModel>? orderList,
    List<OrderModel>? fullfillOrderList,
    List<OrderModel>? unFulfillOrderList,
    List<OrderModel>? archivedOrderList,
    List<OrderStatusModel>? orderStatus,
    OrderPaginationModel? orderModel,
    OrderPaginationModel? fulfillOrderModel,
    OrderPaginationModel? unFulfillOrderModel,
  }) {
    return OrderState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      orderList: orderList ?? this.orderList,
      fullfillOrderList: fullfillOrderList ?? this.fullfillOrderList,
      unFulfillOrderList: unFulfillOrderList ?? this.unFulfillOrderList,
      archivedOrderList: archivedOrderList ?? this.archivedOrderList,
      orderModel: orderModel ?? this.orderModel,
      fulfillOrderModel: fulfillOrderModel ?? this.fulfillOrderModel,
      unFulfillOrderModel: unFulfillOrderModel ?? this.unFulfillOrderModel,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      orderList,
      fullfillOrderList,
      unFulfillOrderList,
      archivedOrderList,
      orderModel,
      fulfillOrderModel,
      unFulfillOrderModel,
    ];
  }

  factory OrderState.init() => OrderState(
        loading: false,
        failure: CleanFailure.none(),
        orderList: const [],
        fullfillOrderList: const [],
        unFulfillOrderList: const [],
        archivedOrderList: const [],
        orderModel: OrderPaginationModel.init(),
        fulfillOrderModel: OrderPaginationModel.init(),
        unFulfillOrderModel: OrderPaginationModel.init(),
      );

  @override
  String toString() {
    return 'OrderState(loading: $loading, failure: $failure, orderList: $orderList, fullfillOrderList: $fullfillOrderList, unFulfillOrderList: $unFulfillOrderList, archivedOrderList: $archivedOrderList, orderModel: $orderModel,fulfillOrderModel: $fulfillOrderModel, unFulfillOrderModel: $unFulfillOrderModel)';
  }
}
