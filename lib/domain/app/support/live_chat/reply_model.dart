import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/order/order_details/customer.dart';

class ReplyModel extends Equatable {
  final int id;
  final String reply;
  final Customer user;
  final dynamic read;
  final String updatedAt;
  final List<dynamic> attachments;
  final Customer customer;

  const ReplyModel({
    required this.id,
    required this.reply,
    required this.user,
    required this.read,
    required this.updatedAt,
    required this.attachments,
    required this.customer,
  });

  ReplyModel copyWith({
    int? id,
    String? reply,
    Customer? user,
    dynamic read,
    String? updatedAt,
    List<dynamic>? attachments,
    Customer? customer,
  }) {
    return ReplyModel(
      id: id ?? this.id,
      reply: reply ?? this.reply,
      user: user ?? this.user,
      read: read ?? this.read,
      updatedAt: updatedAt ?? this.updatedAt,
      attachments: attachments ?? this.attachments,
      customer: customer ?? this.customer,
    );
  }

  factory ReplyModel.fromJson(Map<String, dynamic> json) => ReplyModel(
        id: json["id"].toInt() ?? 0,
        reply: json["reply"] ?? '',
        user: json["user"] != null
            ? Customer.fromJson(json["user"])
            : Customer.init(),
        read: json["read"],
        updatedAt: json["updated_at"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        customer: json["user"] != null
            ? Customer.fromJson(json["user"])
            : Customer.init(),
      );

  factory ReplyModel.init() => ReplyModel(
        id: 0,
        reply: '',
        user: Customer.init(),
        read: '',
        updatedAt: '',
        attachments: [],
        customer: Customer.init(),
      );

  @override
  List<Object?> get props => [
        id,
        reply,
        user,
        read,
        updatedAt,
        attachments,
        customer,
      ];
}
