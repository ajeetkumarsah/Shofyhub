import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationProvider =
    ChangeNotifierProvider((_) => NotificationNotifier());

class NotificationNotifier extends ChangeNotifier {
  String fcmToken = '';

  saveFcmToken(String token) {
    fcmToken = token;
    notifyListeners();
  }
}
