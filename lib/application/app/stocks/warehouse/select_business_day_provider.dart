import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectBusinessDaysProvider =
    ChangeNotifierProvider((ref) => SelectBusinessDaysNotifier());

class SelectBusinessDaysNotifier extends ChangeNotifier {
  List<String> selectedBusinessDays = [];

  addBusinessDays(List<String> businessDays) {
    selectedBusinessDays.clear();
    selectedBusinessDays.addAll(businessDays);
    notifyListeners();
  }

  clear() {
    selectedBusinessDays.clear();
    notifyListeners();
  }
}
