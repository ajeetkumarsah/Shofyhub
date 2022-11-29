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

  File? _categoryImage;
  File? get categoryImage => _categoryImage;

  File? _manufacturerLogo;
  File? get manufacturerLogo => _manufacturerLogo;

  File? _manufacturerCoverImage;
  File? get manufacturerCoverImage => _manufacturerCoverImage;

  File? _manufacturerFeaturedImage;
  File? get manufacturerFeaturedImage => _manufacturerFeaturedImage;

  File? _shopLogo;
  File? get shopLogo => _shopLogo;

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

// CATEGORY
  void pickCategoryImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 600,
          maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _categoryImage = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  void setCategoryImage(File? image) {
    _categoryImage = image;
    notifyListeners();
  }

  void clearCategoryImage() {
    _categoryImage = null;
    notifyListeners();
  }

  // MANUFACTURER LOGO
  void pickManufacturerLogo() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 600,
          maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _manufacturerLogo = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  void setManufacturerLogo(File? image) {
    _manufacturerLogo = image;
    notifyListeners();
  }

  void clearManufacturerLogo() {
    _manufacturerLogo = null;
    notifyListeners();
  }

  // MANUFACTURER COVER IMAGE
  void pickManufacturerCoverImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 600,
          maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _manufacturerCoverImage = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  void setManufacturerCoverImage(File? image) {
    _manufacturerCoverImage = image;
    notifyListeners();
  }

  void clearManufacturerCoverImage() {
    _manufacturerCoverImage = null;
    notifyListeners();
  }

  // MANUFACTURER FEATURED IMAGE
  void pickManufacturerFeaturedImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 600,
          maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _manufacturerFeaturedImage = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  void setManufacturerFeaturedImage(File? image) {
    _manufacturerFeaturedImage = image;
    notifyListeners();
  }

  void clearManufacturerFeaturedImage() {
    _manufacturerFeaturedImage = null;
    notifyListeners();
  }

  // SHOP LOGO
  void pickShopLogo() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 600,
          maxHeight: 600);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _shopLogo = imageTemporary;
    } catch (e) {
      Fluttertoast.showToast(msg: "failed_to_pick_image".tr());
    }
    notifyListeners();
  }

  void setShopLogo(File? image) {
    _shopLogo = image;
    notifyListeners();
  }

  void clearShopLogo() {
    _shopLogo = null;
    notifyListeners();
  }
}
