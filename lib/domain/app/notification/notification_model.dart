import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/notification/notification_data_model.dart';

class NotificationModel extends Equatable {
  final String id;
  final int notificationId;
  final NotificationData data;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotificationModel({
    required this.id,
    required this.notificationId,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  NotificationModel copyWith({
    String? id,
    int? notificationId,
    NotificationData? data,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      notificationId: notificationId ?? this.notificationId,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) =>
      NotificationModel(
        id: map["id"] ?? '',
        notificationId: map["notification_id"] ?? 0,
        data: map["data"] != null
            ? NotificationData.fromMap(map["data"])
            : NotificationData.init(),
        createdAt: DateTime.parse(map["created_at"]),
        updatedAt: DateTime.parse(map["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notification_id": notificationId,
        "data": data.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  factory NotificationModel.init() => NotificationModel(
        id: '',
        notificationId: 0,
        data: NotificationData.init(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [
        id,
        notificationId,
        data,
        createdAt,
        updatedAt,
      ];
}
