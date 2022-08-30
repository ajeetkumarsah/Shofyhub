// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/order/order_details/order_details_model.dart';

class OrderDetailsState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final OrderDetailsModel orderDetails;
  final File? invoice;
  const OrderDetailsState({
    required this.loading,
    required this.failure,
    required this.orderDetails,
    required this.invoice,
  });

  OrderDetailsState copyWith({
    bool? loading,
    CleanFailure? failure,
    OrderDetailsModel? orderDetails,
    File? invoice,
  }) {
    return OrderDetailsState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      orderDetails: orderDetails ?? this.orderDetails,
      invoice: invoice ?? this.invoice,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [loading, failure, orderDetails, invoice];

  factory OrderDetailsState.init() => OrderDetailsState(
      loading: false,
      failure: CleanFailure.none(),
      orderDetails: OrderDetailsModel.init(),
      invoice: null);
}
