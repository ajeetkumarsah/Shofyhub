// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int id;
  final String orderNumber;
  final int customerId;
  final String customerName;
  final int disputeId;
  final String orderStatus;
  final String paymentStatus;
  final String grandTotal;
  final String grandTotalRaw;
  final String orderDate;
  final bool canEvaluate;
  final String trackingId;
  final int itemCount;
  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    required this.customerName,
    required this.disputeId,
    required this.orderStatus,
    required this.paymentStatus,
    required this.grandTotal,
    required this.grandTotalRaw,
    required this.orderDate,
    required this.canEvaluate,
    required this.trackingId,
    required this.itemCount,
  });

  OrderModel copyWith({
    int? id,
    String? orderNumber,
    int? customerId,
    String? customerName,
    int? disputeId,
    String? orderStatus,
    String? paymentStatus,
    String? grandTotal,
    String? grandTotalRaw,
    String? orderDate,
    bool? canEvaluate,
    String? trackingId,
    int? itemCount,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      disputeId: disputeId ?? this.disputeId,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      grandTotal: grandTotal ?? this.grandTotal,
      grandTotalRaw: grandTotalRaw ?? this.grandTotalRaw,
      orderDate: orderDate ?? this.orderDate,
      canEvaluate: canEvaluate ?? this.canEvaluate,
      trackingId: trackingId ?? this.trackingId,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_number': orderNumber,
      'customer_id': customerId,
      'customer_name': customerName,
      'dispute_id': disputeId,
      'order_status': orderStatus,
      'payment_status': paymentStatus,
      'grand_total': grandTotal,
      'grand_total_raw': grandTotalRaw,
      'order_date': orderDate,
      'can_evaluate': canEvaluate,
      'tracking_id': trackingId,
      'item_count': itemCount,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      orderNumber: map['order_number'] ?? '',
      customerId: map['customer_id']?.toInt() ?? 0,
      customerName: map['customer_name'] ?? '',
      disputeId: map['dispute_id']?.toInt() ?? 0,
      orderStatus: map['order_status'] ?? '',
      paymentStatus: map['payment_status'] ?? '',
      grandTotal: map['grand_total'] ?? '',
      grandTotalRaw: map['grand_total_raw'] ?? '',
      orderDate: map['order_date'] ?? '',
      canEvaluate: map['can_evaluate'] ?? false,
      trackingId: map['tracking_id'] ?? '',
      itemCount: map['item_count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderNumber,
      customerId,
      customerName,
      disputeId,
      orderStatus,
      paymentStatus,
      grandTotal,
      grandTotalRaw,
      orderDate,
      canEvaluate,
      trackingId,
      itemCount,
    ];
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, orderNumber: $orderNumber, customerId: $customerId, customerName: $customerName, disputeId: $disputeId, orderStatus: $orderStatus, paymentStatus: $paymentStatus, grandTotal: $grandTotal, grandTotalRaw: $grandTotalRaw, orderDate: $orderDate, canEvaluate: $canEvaluate, trackingId: $trackingId, itemCount: $itemCount)';
  }
}
