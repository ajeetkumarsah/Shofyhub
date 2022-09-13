import 'dart:convert';

import 'package:equatable/equatable.dart';

class RefundModel extends Equatable {
  final int id;
  final int shopId;
  final int orderId;
  final int orderFulfilled;
  final int returnGoods;
  final String amount;
  final String description;
  final int status;
  const RefundModel({
    required this.id,
    required this.shopId,
    required this.orderId,
    required this.orderFulfilled,
    required this.returnGoods,
    required this.amount,
    required this.description,
    required this.status,
  });

  RefundModel copyWith({
    int? id,
    int? shopId,
    int? orderId,
    int? orderFulfilled,
    int? returnGoods,
    String? amount,
    String? description,
    int? status,
  }) {
    return RefundModel(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      orderId: orderId ?? this.orderId,
      orderFulfilled: orderFulfilled ?? this.orderFulfilled,
      returnGoods: returnGoods ?? this.returnGoods,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shop_id': shopId,
      'order_id': orderId,
      'order_fulfilled': orderFulfilled,
      'return_goods': returnGoods,
      'amount': amount,
      'description': description,
      'status': status,
    };
  }

  factory RefundModel.fromMap(Map<String, dynamic> map) {
    return RefundModel(
      id: map['id']?.toInt() ?? 0,
      shopId: map['shop_id']?.toInt() ?? 0,
      orderId: map['order_id']?.toInt() ?? 0,
      orderFulfilled: map['order_fulfilled']?.toInt() ?? 0,
      returnGoods: map['return_goods']?.toInt() ?? 0,
      amount: map['amount'] ?? '',
      description: map['description'] ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RefundModel.fromJson(String source) =>
      RefundModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RefundModel(id: $id, shopId: $shopId, orderId: $orderId, orderFulfilled: $orderFulfilled, returnGoods: $returnGoods, amount: $amount, description: $description, status: $status)';
  }

  @override
  List<Object> get props {
    return [
      id,
      shopId,
      orderId,
      orderFulfilled,
      returnGoods,
      amount,
      description,
      status,
    ];
  }

  factory RefundModel.init() => const RefundModel(
      id: 0,
      shopId: 0,
      orderId: 0,
      orderFulfilled: 0,
      returnGoods: 0,
      amount: '',
      description: '',
      status: 0);
}
