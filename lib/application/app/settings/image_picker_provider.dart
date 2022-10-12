import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider =
    ChangeNotifierProvider((ref) => ImagePickerNotifier());

class ImagePickerNotifier extends ChangeNotifier {
  final picker = ImagePicker();
  File? profileImage;
  File? coverImage;

  pickProfileImage(
      BuildContext context, ImageSource source, WidgetRef ref) async {
    try {
      final image = await picker.pickImage(
          source: source, imageQuality: 50, maxWidth: 600, maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      profileImage = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to pick Image");
    }
    notifyListeners();
  }

  pickCoverImage(
      BuildContext context, ImageSource source, WidgetRef ref) async {
    try {
      final image = await picker.pickImage(
          source: source, imageQuality: 50, maxWidth: 600, maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      coverImage = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to pick Image");
    }
    notifyListeners();
  }
}
