import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/order/order_details/customer.dart';
import 'package:zcart_seller/domain/app/shop/user/get_shop_users_model.dart';
import 'package:zcart_seller/domain/app/support/live_chat/reply_model.dart';

class ConversessionModel extends Equatable {
  final int id;
  final int shopId;
  final Customer customer;
  final ShopUsersModel shop;
  final dynamic subject;
  final String message;
  final dynamic item;
  final int status;
  final dynamic label;
  final List<dynamic> attachments;
  final List<ReplyModel> replies;

  const ConversessionModel({
    required this.id,
    required this.shopId,
    required this.customer,
    required this.shop,
    required this.subject,
    required this.message,
    required this.item,
    required this.status,
    required this.label,
    required this.attachments,
    required this.replies,
  });

  ConversessionModel copyWith({
    int? id,
    int? shopId,
    Customer? customer,
    ShopUsersModel? shop,
    dynamic subject,
    String? message,
    dynamic item,
    int? status,
    dynamic label,
    List<dynamic>? attachments,
    List<ReplyModel>? replies,
  }) {
    return ConversessionModel(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      customer: customer ?? this.customer,
      shop: shop ?? this.shop,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      item: item ?? this.item,
      status: status ?? this.status,
      label: label ?? this.label,
      attachments: attachments ?? this.attachments,
      replies: replies ?? this.replies,
    );
  }

  factory ConversessionModel.fromJson(Map<String, dynamic> json) =>
      ConversessionModel(
        id: json["id"].toInt() ?? 0,
        shopId: json["shop_id"].toInt() ?? 0,
        customer: Customer.fromJson(json["customer"]),
        shop: ShopUsersModel.fromJson(json["shop"]),
        subject: json["subject"] ?? '',
        message: json["message"] ?? '',
        item: json["item"],
        status: json["status"] ?? 0,
        label: json["label"] ?? '',
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        replies: List<ReplyModel>.from(
            json["replies"].map((x) => ReplyModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [
        id,
        shopId,
        customer,
        shop,
        subject,
        message,
        item,
        status,
        label,
        attachments,
        replies,
      ];

  factory ConversessionModel.init() => ConversessionModel(
        id: 0,
        shopId: 0,
        customer: Customer.init(),
        shop: ShopUsersModel.init(),
        subject: '',
        message: '',
        item: '',
        status: 0,
        label: '',
        attachments: const [],
        replies: const [],
      );
}
