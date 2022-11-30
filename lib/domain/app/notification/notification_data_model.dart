import 'package:equatable/equatable.dart';

class NotificationData extends Equatable {
  final String order;
  final dynamic deviceId;
  final int orderId;
  final String customer;
  final String subject;
  final String message;

  const NotificationData({
    required this.order,
    required this.deviceId,
    required this.orderId,
    required this.customer,
    required this.subject,
    required this.message,
  });

  NotificationData copyWith({
    String? order,
    dynamic deviceId,
    int? orderId,
    String? customer,
    String? subject,
    String? message,
  }) {
    return NotificationData(
      order: order ?? this.order,
      deviceId: deviceId ?? this.deviceId,
      orderId: orderId ?? this.orderId,
      customer: customer ?? this.customer,
      subject: subject ?? this.subject,
      message: message ?? this.message,
    );
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) =>
      NotificationData(
        order: map["order"] ?? '',
        deviceId: map["device_id"] ?? '',
        orderId: map["order_id"] ?? 0,
        customer: map["customer"] ?? '',
        subject: map["subject"] ?? '',
        message: map["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "device_id": deviceId,
        "order_id": orderId,
        "customer": customer,
        "subject": subject,
        "message": message,
      };

  factory NotificationData.init() => const NotificationData(
        order: '',
        deviceId: '',
        orderId: 0,
        customer: '',
        subject: '',
        message: '',
      );

  @override
  List<Object?> get props => [
        order,
        deviceId,
        orderId,
        customer,
        subject,
        message,
      ];
}
