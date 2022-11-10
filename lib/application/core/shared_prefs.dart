import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zcart_seller/infrastructure/app/notification/notification_model.dart';

class SharedPref {
  static const notificationKey = 'notification';

  static saveNotifications({required NotificationModel messages}) async {
    List<NotificationModel> notificationModel = [];
    notificationModel.add(messages);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(notificationKey, jsonEncode(notificationModel));
  }

  static getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var notificationsDataFromPrefs = prefs.getString(notificationKey);
    if (notificationsDataFromPrefs != null) {
      List<NotificationModel> notifications =
          jsonDecode(notificationsDataFromPrefs) as List<NotificationModel>;
      return notifications;
    }
  }
}
