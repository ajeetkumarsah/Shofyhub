import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alpesportif_seller/domain/app/notification/notification_model.dart';

class SharedPref {
  static const notificationKey = 'notification';
  static const fcmTokenKey = 'fcmToken';

  List<NotificationModel> notificationList = [];

  static saveFcmToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(fcmTokenKey, jsonEncode(token));
  }

  static Future<String> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(fcmTokenKey) ?? '';
  }

  static saveAllNotifications(
      {required List<NotificationModel> messages}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(notificationKey, jsonEncode(messages));
  }

  static getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var notificationsDataFromPrefs = prefs.getString(notificationKey);
    if (notificationsDataFromPrefs != null) {
      final notificationDecoded =
          jsonDecode(notificationsDataFromPrefs) as List<dynamic>;

      List<NotificationModel> notificationList = List<NotificationModel>.from(
          notificationDecoded.map((e) => NotificationModel.fromMap(e)));
      return notificationList;
    }
  }
}
