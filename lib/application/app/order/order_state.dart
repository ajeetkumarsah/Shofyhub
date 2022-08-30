// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/order/order_model.dart';
import 'package:zcart_seller/domain/app/order/order_status_model.dart';

class OrderState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<OrderModel> orderList;

  const OrderState({
    required this.loading,
    required this.failure,
    required this.orderList,
  });

  OrderState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<OrderModel>? orderList,
    List<OrderModel>? unfullfilledOrderList,
    List<OrderModel>? arcivedOrderList,
    List<OrderStatusModel>? orderStatus,
  }) {
    return OrderState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      orderList: orderList ?? this.orderList,
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
    ];
  }

  factory OrderState.init() => OrderState(
        loading: false,
        failure: CleanFailure.none(),
        orderList: const [],
      );

  @override
  String toString() {
    return 'OrderState(loading: $loading, failure: $failure, orderList: $orderList)';
  }
}
