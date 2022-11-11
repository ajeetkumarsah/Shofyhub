import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/domain/app/notification/notification_model.dart';

final notificationProvider =
    ChangeNotifierProvider((_) => NotificationNotifier());

class NotificationNotifier extends ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  String fcmToken = '';

  saveFcmToken(String token) {
    fcmToken = token;
    notifyListeners();
  }

  saveNotification(List<NotificationModel> notificationList) {
    notifications.addAll(notificationList);
    notifyListeners();
  }
}
