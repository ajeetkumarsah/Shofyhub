import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/order/order_details/customer.dart';

class ReplyModel extends Equatable {
  final int id;
  final String reply;
  final Customer? customer;
  final dynamic read;
  final String updatedAt;
  final List<dynamic> attachments;
  final Customer user;

  const ReplyModel({
    required this.id,
    required this.reply,
    required this.customer,
    required this.read,
    required this.updatedAt,
    required this.attachments,
    required this.user,
  });

  ReplyModel copyWith({
    int? id,
    String? reply,
    Customer? customer,
    dynamic read,
    String? updatedAt,
    List<dynamic>? attachments,
    Customer? user,
  }) {
    return ReplyModel(
      id: id ?? this.id,
      reply: reply ?? this.reply,
      customer: customer ?? this.customer,
      read: read ?? this.read,
      updatedAt: updatedAt ?? this.updatedAt,
      attachments: attachments ?? this.attachments,
      user: user ?? this.user,
    );
  }

  factory ReplyModel.fromMap(Map<String, dynamic> map) => ReplyModel(
        id: map["id"].toInt() ?? 0,
        reply: map["reply"] ?? '',
        customer: map["customer"] != null
            ? Customer.fromMap(map["customer"])
            : Customer.init(),
        read: map["read"],
        updatedAt: map["updated_at"],
        attachments: List<dynamic>.from(map["attachments"].map((x) => x)),
        user: map["user"] != null
            ? Customer.fromMap(map["user"])
            : Customer.init(),
      );

  factory ReplyModel.init() => ReplyModel(
        id: 0,
        reply: '',
        customer: Customer.init(),
        read: '',
        updatedAt: '',
        attachments: const [],
        user: Customer.init(),
      );

  @override
  List<Object?> get props => [
        id,
        reply,
        customer,
        read,
        updatedAt,
        attachments,
        user,
      ];
}
