import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationProvider =
    ChangeNotifierProvider((_) => NotificationNotifier());

class NotificationNotifier extends ChangeNotifier {
  String fcmToken = '';

  int _notificationCount = 0;
  int get notificationCount => _notificationCount;

  void increamentNotificationCount(int count) {
    _notificationCount += count;
    notifyListeners();
  }

  void clearNotificationCount() {
    _notificationCount = 0;
    notifyListeners();
  }

  void saveFcmToken(String token) {
    fcmToken = token;
    notifyListeners();
  }
}
