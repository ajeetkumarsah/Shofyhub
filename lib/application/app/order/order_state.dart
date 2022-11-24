// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/order/order_model.dart';
import 'package:zcart_seller/domain/app/order/order_status_model.dart';

class OrderState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<OrderModel> orderList;
  final List<OrderModel> fullfillOrderList;
  final List<OrderModel> unFulfillOrderList;
  final List<OrderModel> archivedOrderList;

  const OrderState({
    required this.loading,
    required this.failure,
    required this.orderList,
    required this.fullfillOrderList,
    required this.unFulfillOrderList,
    required this.archivedOrderList,
  });

  OrderState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<OrderModel>? orderList,
    List<OrderModel>? fullfillOrderList,
    List<OrderModel>? unFulfillOrderList,
    List<OrderModel>? archivedOrderList,
    List<OrderStatusModel>? orderStatus,
  }) {
    return OrderState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      orderList: orderList ?? this.orderList,
      fullfillOrderList: fullfillOrderList ?? this.fullfillOrderList,
      unFulfillOrderList: unFulfillOrderList ?? this.unFulfillOrderList,
      archivedOrderList: archivedOrderList ?? this.archivedOrderList,
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
    ];
  }

  factory OrderState.init() => OrderState(
        loading: false,
        failure: CleanFailure.none(),
        orderList: const [],
        fullfillOrderList: const [],
        unFulfillOrderList: const [],
        archivedOrderList: const [],
      );

  @override
  String toString() {
    return 'OrderState(loading: $loading, failure: $failure, orderList: $orderList, fullfillOrderList: $fullfillOrderList, unFulfillOrderList: $unFulfillOrderList, archivedOrderList: $archivedOrderList)';
  }
}
