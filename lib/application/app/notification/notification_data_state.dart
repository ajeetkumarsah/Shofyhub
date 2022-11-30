// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/notification/notification_model.dart';

class NotificationDataState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<NotificationModel> notificationList;

  const NotificationDataState({
    required this.loading,
    required this.failure,
    required this.notificationList,
  });

  NotificationDataState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<NotificationModel>? notificationList,
  }) {
    return NotificationDataState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      notificationList: notificationList ?? this.notificationList,
    );
  }

  @override
  String toString() =>
      'NotificationDataState(loading: $loading, failure: $failure, notificationList: $notificationList)';

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      notificationList,
    ];
  }

  factory NotificationDataState.init() => NotificationDataState(
        loading: false,
        failure: CleanFailure.none(),
        notificationList: const [],
      );

  @override
  bool get stringify => true;
}
