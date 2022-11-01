import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final productImagePickerProvider =
    ChangeNotifierProvider((ref) => ProductImagePickerNotifier());

class ProductImagePickerNotifier extends ChangeNotifier {
  final _picker = ImagePicker();
  List<File> productImages = [];

  File? _featuredImage;

  File? get featuredImage => _featuredImage;

  void pickProductImages() async {
    try {
      final images =
          await _picker.pickMultiImage(maxWidth: 2000, maxHeight: 2000);
      if (images == null) return;
      for (XFile image in images) {
        var imagesTemporary = File(image.path);
        productImages.add(imagesTemporary);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  pickFeaturedImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 600,
          maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _featuredImage = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  void removeFeaturedImage() {
    _featuredImage = null;
    notifyListeners();
  }

  void removeImage(int index) {
    productImages.removeAt(index);
    notifyListeners();
  }

  void clearAllImages() {
    productImages.clear();
    _featuredImage = null;
    notifyListeners();
  }
}
