// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/shop/delivery%20boy/delivary_boy_model.dart';

class DisputeOrderDetailsModel extends Equatable {
  final int id;
  final String orderNumber;
  final int customerId;
  final String customerName;
  final int disputeId;
  final String orderStatus;
  final String paymentStatus;
  final String messageToCutomer;
  final String grandTotal;
  final String grandTotalRaw;
  final String orderDate;
  final String shippingDate;
  final String deliveryDate;
  final bool goodsRecieved;
  final bool canEvaluate;
  final String trackingId;
  final String trackingUrl;
  final int itemCount;
  final DelivaryBoyModel deliveryBoy;

  const DisputeOrderDetailsModel({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    required this.customerName,
    required this.disputeId,
    required this.orderStatus,
    required this.paymentStatus,
    required this.messageToCutomer,
    required this.grandTotal,
    required this.grandTotalRaw,
    required this.orderDate,
    required this.shippingDate,
    required this.deliveryDate,
    required this.goodsRecieved,
    required this.canEvaluate,
    required this.trackingId,
    required this.trackingUrl,
    required this.itemCount,
    required this.deliveryBoy,
  });

  DisputeOrderDetailsModel copyWith({
    int? id,
    String? orderNumber,
    int? customerId,
    String? customerName,
    int? disputeId,
    String? orderStatus,
    String? paymentStatus,
    String? messageToCutomer,
    String? grandTotal,
    String? grandTotalRaw,
    String? orderDate,
    String? shippingDate,
    String? deliveryDate,
    bool? goodsRecieved,
    bool? canEvaluate,
    String? trackingId,
    String? trackingUrl,
    int? itemCount,
    DelivaryBoyModel? deliveryBoy,
  }) {
    return DisputeOrderDetailsModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      disputeId: disputeId ?? this.disputeId,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      messageToCutomer: messageToCutomer ?? this.messageToCutomer,
      grandTotal: grandTotal ?? this.grandTotal,
      grandTotalRaw: grandTotalRaw ?? this.grandTotalRaw,
      orderDate: orderDate ?? this.orderDate,
      shippingDate: shippingDate ?? this.shippingDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      goodsRecieved: goodsRecieved ?? this.goodsRecieved,
      canEvaluate: canEvaluate ?? this.canEvaluate,
      trackingId: trackingId ?? this.trackingId,
      trackingUrl: trackingUrl ?? this.trackingUrl,
      itemCount: itemCount ?? this.itemCount,
      deliveryBoy: deliveryBoy ?? this.deliveryBoy,
    );
  }

  factory DisputeOrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return DisputeOrderDetailsModel(
      id: map['id']?.toInt() ?? 0,
      orderNumber: map['order_number'] ?? '',
      customerId: map['customer_id']?.toInt() ?? 0,
      customerName: map['customer_name'] ?? '',
      disputeId: map['dispute_id']?.toInt() ?? 0,
      orderStatus: map['order_status'] ?? '',
      paymentStatus: map['payment_status'] ?? '',
      messageToCutomer: map['message_to_customer'] ?? '',
      grandTotal: map['grand_total'] ?? '',
      grandTotalRaw: map['grand_total_raw'] ?? '',
      orderDate: map['order_date'] ?? '',
      shippingDate: map['shipping_date'] ?? '',
      deliveryDate: map['delivery_date'] ?? '',
      goodsRecieved: map['goods_received'] ?? false,
      canEvaluate: map['can_evaluate'] ?? false,
      trackingId: map['tracking_id'] ?? 0,
      trackingUrl: map['tracking_url'] ?? '',
      itemCount: map['item_count'] ?? 0,
      deliveryBoy: map['delivery_boy'] != null
          ? DelivaryBoyModel.fromMap(map['delivery_boy'])
          : DelivaryBoyModel.init(),
    );
  }

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
      messageToCutomer,
      grandTotal,
      grandTotalRaw,
      orderDate,
      shippingDate,
      deliveryDate,
      canEvaluate,
      trackingId,
      trackingUrl,
      itemCount,
      deliveryBoy,
    ];
  }

  factory DisputeOrderDetailsModel.init() => DisputeOrderDetailsModel(
        id: 0,
        orderNumber: '',
        customerId: 0,
        customerName: '',
        disputeId: 0,
        orderStatus: '',
        paymentStatus: '',
        messageToCutomer: '',
        grandTotal: '',
        grandTotalRaw: '',
        orderDate: '',
        shippingDate: '',
        deliveryDate: '',
        goodsRecieved: false,
        canEvaluate: false,
        trackingId: '',
        trackingUrl: '',
        itemCount: 0,
        deliveryBoy: DelivaryBoyModel.init(),
      );
}
