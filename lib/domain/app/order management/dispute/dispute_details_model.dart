import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/order/order_details/order_details_model.dart';
import 'package:alpesportif_seller/domain/auth/user_model.dart';

class DisputeDetailsModel extends Equatable {
  final int id;
  final String reason;
  final double progress;
  final bool closed;
  final String description;
  final bool goodsReceived;
  final dynamic returnGoods;
  final String status;
  final String refundAmount;
  final String refundAmountRaw;
  final String updatedAt;
  final UserModel customer;
  final OrderDetailsModel orderDetails;
  final List<dynamic> attachments;
  final List<dynamic> replies;

  const DisputeDetailsModel({
    required this.id,
    required this.reason,
    required this.progress,
    required this.closed,
    required this.description,
    required this.goodsReceived,
    required this.returnGoods,
    required this.status,
    required this.refundAmount,
    required this.refundAmountRaw,
    required this.updatedAt,
    required this.customer,
    required this.orderDetails,
    required this.attachments,
    required this.replies,
  });

  DisputeDetailsModel copyWith({
    int? id,
    String? reason,
    double? progress,
    bool? closed,
    String? description,
    bool? goodsReceived,
    dynamic returnGoods,
    String? status,
    String? refundAmount,
    String? refundAmountRaw,
    String? updatedAt,
    UserModel? customer,
    OrderDetailsModel? orderDetails,
    List<dynamic>? attachments,
    List<dynamic>? replies,
  }) {
    return DisputeDetailsModel(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      progress: progress ?? this.progress,
      closed: closed ?? this.closed,
      description: description ?? this.description,
      goodsReceived: goodsReceived ?? this.goodsReceived,
      returnGoods: returnGoods ?? this.returnGoods,
      status: status ?? this.status,
      refundAmount: refundAmount ?? this.refundAmount,
      refundAmountRaw: refundAmountRaw ?? this.refundAmountRaw,
      updatedAt: updatedAt ?? this.updatedAt,
      customer: customer ?? this.customer,
      orderDetails: orderDetails ?? this.orderDetails,
      attachments: attachments ?? this.attachments,
      replies: replies ?? this.replies,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reason': reason,
      'progress': progress,
      'closed': closed,
      'description': description,
      'goods_received': goodsReceived,
      'return_goods': returnGoods,
      'status': status,
      'refund_amount': refundAmount,
      'refund_amount_raw': refundAmountRaw,
      'updated_at': updatedAt,
      'customer': customer,
      'order_details': orderDetails,
      'attachments': attachments,
      'replies': replies,
    };
  }

  factory DisputeDetailsModel.fromMap(Map<String, dynamic> map) {
    return DisputeDetailsModel(
      id: map['id']?.toInt() ?? 0,
      reason: map['reason'] ?? '',
      progress: map['progress'].toDouble() ?? 0,
      closed: map['closed'] ?? '',
      description: map['description'] ?? '',
      goodsReceived: map['goods_received'] ?? '',
      returnGoods: map['return_goods'] ?? '',
      status: map['status'] ?? '',
      refundAmount: map['refund_amount'] ?? '',
      refundAmountRaw: map['refund_amount_raw'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      customer: map['customer'] != null
          ? UserModel.fromMap(map['customer'])
          : UserModel.init(),
      orderDetails: map['order_details'] != null
          ? OrderDetailsModel.fromMap(map['order_details'])
          : OrderDetailsModel.init(),
      attachments: map['attachments'] ?? '',
      replies: map['replies'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DisputeDetailsModel.fromJson(String source) =>
      DisputeDetailsModel.fromMap(json.decode(source));

  factory DisputeDetailsModel.init() => DisputeDetailsModel(
        id: 0,
        reason: '',
        progress: 0,
        closed: false,
        description: '',
        goodsReceived: false,
        returnGoods: false,
        status: '',
        refundAmount: '',
        refundAmountRaw: '',
        updatedAt: '',
        customer: UserModel.init(),
        orderDetails: OrderDetailsModel.init(),
        attachments: const [],
        replies: const [],
      );

  @override
  List<Object?> get props => [
        id,
        reason,
        progress,
        closed,
        description,
        goodsReceived,
        returnGoods,
        status,
        refundAmount,
        refundAmountRaw,
        updatedAt,
        customer,
        orderDetails,
        attachments,
        replies,
      ];
}
