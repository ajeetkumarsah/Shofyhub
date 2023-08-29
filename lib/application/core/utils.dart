import 'package:easy_localization/easy_localization.dart';

class Utils {
  static dateTimeFormat(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd hh:mm aa').format(dateTime);
  }
}

// Demo App //TODO: Remove this before release
const bool isDemoApp = false;
