import 'dart:convert';

import 'package:equatable/equatable.dart';

class CancellationModel extends Equatable {
  final int id;
  final int shopId;
  final int cancellationReasonId;
  final int customerId;
  final int orderId;
  // final List<String> items;
  final String description;
  final dynamic returnGoods;
  final int status;

  const CancellationModel({
    required this.id,
    required this.shopId,
    required this.cancellationReasonId,
    required this.customerId,
    required this.orderId,
    // required this.items,
    required this.description,
    required this.returnGoods,
    required this.status,
  });

  CancellationModel copyWith({
    int? id,
    int? shopId,
    int? cancellationReasonId,
    int? customerId,
    int? orderId,
    // List<String>? items,
    String? description,
    dynamic returnGoods,
    int? status,
  }) {
    return CancellationModel(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      cancellationReasonId: cancellationReasonId ?? this.cancellationReasonId,
      customerId: customerId ?? this.customerId,
      orderId: orderId ?? this.orderId,
      // items: items ?? this.items,
      description: description ?? this.description,
      returnGoods: returnGoods ?? this.returnGoods,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "shop_id": shopId,
      "cancellation_reason_id": cancellationReasonId,
      "customer_id": customerId,
      "order_id": orderId,
      // "items": items != null ? List<dynamic>.from(items.map((x) => x)) : null,
      "description": description,
      "return_goods": returnGoods,
      "status": status,
    };
  }

  factory CancellationModel.fromMap(Map<String, dynamic> map) {
    return CancellationModel(
      id: map['id']?.toInt() ?? 0,
      shopId: map["shop_id"] ?? 0,
      cancellationReasonId: map["cancellation_reason_id"] ?? 0,
      customerId: map["customer_id"] ?? 0,
      orderId: map["order_id"] ?? 0,
      // items: List<String>.from(map["items"].map((x) => x)),
      description: map["description"] ?? '',
      returnGoods: map["return_goods"] ?? false,
      status: map["status"] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CancellationModel.fromJson(String source) =>
      CancellationModel.fromMap(json.decode(source));

  factory CancellationModel.init() => const CancellationModel(
        id: 0,
        shopId: 0,
        cancellationReasonId: 0,
        customerId: 0,
        orderId: 0,
        // items: [],
        description: '',
        returnGoods: false,
        status: 0,
      );

  @override
  List<Object?> get props => [
        id,
        shopId,
        cancellationReasonId,
        customerId,
        orderId,
        // items,
        description,
        returnGoods,
        status,
      ];
}
