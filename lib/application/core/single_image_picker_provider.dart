import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final singleImagePickerProvider =
    ChangeNotifierProvider((ref) => ProductImagePickerNotifier());

class ProductImagePickerNotifier extends ChangeNotifier {
  final _picker = ImagePicker();

  File? _categoryGroupImage;
  File? get categoryGroupImage => _categoryGroupImage;

  File? _categorySubGroupImage;
  File? get categorySubGroupImage => _categorySubGroupImage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void pickCategoryGroupImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 600,
          maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _categoryGroupImage = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  void setCategoryGroupImage(File? image) {
    _categoryGroupImage = image;
    notifyListeners();
  }

  void clearCategoryGroupImage() {
    _categoryGroupImage = null;
    notifyListeners();
  }

// CATEGORY SUB GROUP
  void pickCategorySubGroupImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 600,
          maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _categorySubGroupImage = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  void setCategorySubGroupImage(File? image) {
    _categorySubGroupImage = image;
    notifyListeners();
  }

  void clearCategorySubGroupImage() {
    _categorySubGroupImage = null;
    notifyListeners();
  }
}
