import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationHelper {
  static info({required String message}) {
    return showSimpleNotification(
      Text(message),
      position: NotificationPosition.bottom,
      background: Colors.blue,
    );
  }

  static success({required String message}) {
    return showSimpleNotification(
      Text(message),
      position: NotificationPosition.bottom,
      background: Colors.green,
    );
  }

  static error({required String message}) {
    return showSimpleNotification(
      Text(message),
      position: NotificationPosition.bottom,
      background: Colors.red,
    );
  }
}
