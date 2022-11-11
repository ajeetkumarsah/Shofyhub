import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String description;
  final DateTime dateTime;

  const NotificationModel({
    required this.title,
    required this.description,
    required this.dateTime,
  });

  NotificationModel copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'datetime': dateTime.toIso8601String(),
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dateTime: DateTime.tryParse(map['datetime']) ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        dateTime,
      ];
}
