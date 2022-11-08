import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String description;

  const NotificationModel({
    required this.title,
    required this.description,
  });

  NotificationModel copyWith({
    String? title,
    String? description,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
      ];
}
