import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:alpesportif_seller/domain/app/order/order_status_model.dart';

class OrderStatusState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<OrderStatusModel> orderStatus;
  const OrderStatusState({
    required this.loading,
    required this.failure,
    required this.orderStatus,
  });

  OrderStatusState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<OrderStatusModel>? orderStatus,
  }) {
    return OrderStatusState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  @override
  String toString() =>
      'OrderStatusState(loading: $loading, failure: $failure, orderStatus: $orderStatus)';

  @override
  List<Object> get props => [loading, failure, orderStatus];
}
