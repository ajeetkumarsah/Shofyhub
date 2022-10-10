import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final permissionProvider =
    ChangeNotifierProvider((ref) => PermissionNotifier());

class PermissionNotifier extends ChangeNotifier {
  final List<int> selectedPermissionIds = [];

  addId(int id) {
    selectedPermissionIds.add(id);
    notifyListeners();
  }

  removeId(int id) {
    selectedPermissionIds.remove(id);
    notifyListeners();
  }
}
