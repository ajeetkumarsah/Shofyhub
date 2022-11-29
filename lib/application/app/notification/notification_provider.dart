import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/shared_prefs.dart';
import 'package:zcart_seller/domain/app/notification/notification_model.dart';

final notificationProvider =
    ChangeNotifierProvider((_) => NotificationNotifier());

class NotificationNotifier extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  String fcmToken = '';

  saveFcmToken(String token) {
    fcmToken = token;
    notifyListeners();
  }

  saveNotification(NotificationModel notification) {
    notifications.add(notification);
    SharedPref.saveAllNotifications(messages: notifications);
    notifyListeners();
  }

  saveAllNotification(List<NotificationModel> notificationList) {
    notifications.addAll(notificationList);
    SharedPref.saveAllNotifications(messages: notifications);
    notifyListeners();
  }

  removeNotification(DateTime dateTime) {
    notifications.remove(_notifications
        .where((element) => element.dateTime == dateTime)
        .toList()[0]);
    SharedPref.saveAllNotifications(messages: notifications);
    notifyListeners();
  }
}
