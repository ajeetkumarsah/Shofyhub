// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zcart_vendor/domain/app/order/order_details/customer.dart';
import 'package:zcart_vendor/domain/app/order/order_details/items.dart';
import 'package:zcart_vendor/domain/app/order/order_details/payment_method.dart';

class OrderDetailsModel extends Equatable {
  final int id;
  final String order_number;
  final int customer_id;
  final String customerName;
  final String customer_phone_number;
  final String order_status;
  final String payment_status;
  final PaymentMethod payment_method;
  final Customer? customer;
  final List<Items> items;
  final String buyer_note;
  final int shipping_rate_id;

  final String shipping_address;
  final String billing_address;
  final String shipping_weight;
  final String total;
  final String shipping;
  final String grand_total;
  final String order_date;
  final bool can_evaluate;
  final String tracking_id;
  final String taxes;
  final String discount;
  final String packaging;
  final String handling;

  const OrderDetailsModel({
    required this.id,
    required this.order_number,
    required this.customer_id,
    required this.customerName,
    required this.customer_phone_number,
    required this.order_status,
    required this.payment_status,
    required this.payment_method,
    this.customer,
    required this.items,
    required this.buyer_note,
    required this.shipping_rate_id,
    required this.shipping_address,
    required this.billing_address,
    required this.shipping_weight,
    required this.total,
    required this.shipping,
    required this.grand_total,
    required this.order_date,
    required this.can_evaluate,
    required this.tracking_id,
    required this.taxes,
    required this.discount,
    required this.packaging,
    required this.handling,
  });

  OrderDetailsModel copyWith({
    int? id,
    String? order_number,
    int? customer_id,
    String? customerName,
    String? customer_phone_number,
    String? order_status,
    String? payment_status,
    PaymentMethod? payment_method,
    Customer? customer,
    List<Items>? items,
    String? buyer_note,
    int? shipping_rate_id,
    String? shipping_address,
    String? billing_address,
    String? shipping_weight,
    String? total,
    String? shipping,
    String? grand_total,
    String? order_date,
    bool? can_evaluate,
    String? tracking_id,
    String? taxes,
    String? discount,
    String? packaging,
    String? handling,
  }) {
    return OrderDetailsModel(
      id: id ?? this.id,
      order_number: order_number ?? this.order_number,
      customer_id: customer_id ?? this.customer_id,
      customerName: customerName ?? this.customerName,
      customer_phone_number:
          customer_phone_number ?? this.customer_phone_number,
      order_status: order_status ?? this.order_status,
      payment_status: payment_status ?? this.payment_status,
      payment_method: payment_method ?? this.payment_method,
      customer: customer ?? this.customer,
      items: items ?? this.items,
      buyer_note: buyer_note ?? this.buyer_note,
      shipping_rate_id: shipping_rate_id ?? this.shipping_rate_id,
      shipping_address: shipping_address ?? this.shipping_address,
      billing_address: billing_address ?? this.billing_address,
      shipping_weight: shipping_weight ?? this.shipping_weight,
      total: total ?? this.total,
      shipping: shipping ?? this.shipping,
      grand_total: grand_total ?? this.grand_total,
      order_date: order_date ?? this.order_date,
      can_evaluate: can_evaluate ?? this.can_evaluate,
      tracking_id: tracking_id ?? this.tracking_id,
      taxes: taxes ?? this.taxes,
      discount: discount ?? this.discount,
      packaging: packaging ?? this.packaging,
      handling: handling ?? this.handling,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_number': order_number,
      'customer_id': customer_id,
      'customer_name': customerName,
      'customer_phone_number': customer_phone_number,
      'order_status': order_status,
      'payment_status': payment_status,
      'payment_method': payment_method.toMap(),
      'customer': customer?.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
      'buyer_note': buyer_note,
      'shipping_rate_id': shipping_rate_id,
      'shipping_address': shipping_address,
      'billing_address': billing_address,
      'shipping_weight': shipping_weight,
      'total': total,
      'shipping': shipping,
      'grand_total': grand_total,
      'order_date': order_date,
      'can_evaluate': can_evaluate,
      'tracking_id': tracking_id,
      'taxes': taxes,
      'discount': discount,
      'packaging': packaging,
      'handling': handling,
    };
  }

  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      id: map['id']?.toInt() ?? 0,
      order_number: map['order_number'] ?? '',
      customer_id: map['customer_id']?.toInt() ?? 0,
      customerName: map['customer_name'] ?? '',
      customer_phone_number: map['customer_phone_number'] ?? '',
      order_status: map['order_status'] ?? '',
      payment_status: map['payment_status'] ?? '',
      payment_method: PaymentMethod.fromMap(map['payment_method']),
      customer:
          map['customer'] != null ? Customer.fromMap(map['customer']) : null,
      items: List<Items>.from(
          map['items']?.map((x) => Items.fromMap(x)) ?? const []),
      buyer_note: map['buyer_note'] ?? '',
      shipping_rate_id: map['shipping_rate_id']?.toInt() ?? 0,
      shipping_address: map['shipping_address'] ?? '',
      billing_address: map['billing_address'] ?? '',
      shipping_weight: map['shipping_weight'] ?? '',
      total: map['total'] ?? '',
      shipping: map['shipping'] ?? '',
      grand_total: map['grand_total'] ?? '',
      order_date: map['order_date'] ?? '',
      can_evaluate: map['can_evaluate'] ?? false,
      tracking_id: map['tracking_id'] ?? '',
      taxes: map['taxes'] ?? '',
      discount: map['discount'] ?? '',
      packaging: map['packaging'] ?? '',
      handling: map['handling'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsModel.fromJson(String source) =>
      OrderDetailsModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      order_number,
      customer_id,
      customerName,
      customer_phone_number,
      order_status,
      payment_status,
      payment_method,
      customer!,
      items,
      buyer_note,
      shipping_rate_id,
      shipping_address,
      billing_address,
      shipping_weight,
      total,
      shipping,
      grand_total,
      order_date,
      can_evaluate,
      tracking_id,
      taxes,
      discount,
      packaging,
      handling,
    ];
  }

  factory OrderDetailsModel.init() => OrderDetailsModel(
      id: 0,
      order_number: '',
      customer_id: 0,
      customer_phone_number: '',
      order_status: '',
      payment_status: '',
      payment_method: PaymentMethod.init(),
      customer: Customer.init(),
      items: const [],
      buyer_note: '',
      shipping_rate_id: 0,
      shipping_address: '',
      billing_address: '',
      shipping_weight: '',
      total: '',
      shipping: '',
      grand_total: '',
      order_date: '',
      can_evaluate: false,
      tracking_id: '',
      taxes: '',
      discount: '',
      packaging: '',
      handling: '',
      customerName: '');

  @override
  String toString() {
    return 'OrderDetailsModel(id: $id, order_number: $order_number, customer_id: $customer_id, customerName: $customerName, customer_phone_number: $customer_phone_number, order_status: $order_status, payment_status: $payment_status, payment_method: $payment_method, customer: $customer, items: $items, buyer_note: $buyer_note, shipping_rate_id: $shipping_rate_id, shipping_address: $shipping_address, billing_address: $billing_address, shipping_weight: $shipping_weight, total: $total, shipping: $shipping, grand_total: $grand_total, order_date: $order_date, can_evaluate: $can_evaluate, tracking_id: $tracking_id, taxes: $taxes, discount: $discount, packaging: $packaging, handling: $handling)';
  }
}
