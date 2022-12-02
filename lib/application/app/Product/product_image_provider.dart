import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageModel extends Equatable {
  final String imageId;
  final File image;

  const CustomImageModel({required this.imageId, required this.image});

  @override
  List<Object?> get props => [imageId, image];
}

final productImagePickerProvider =
    ChangeNotifierProvider((ref) => ProductImagePickerNotifier());

class ProductImagePickerNotifier extends ChangeNotifier {
  final _picker = ImagePicker();
  List<CustomImageModel> productImages = [];
  List<CustomImageModel> newProductImages = [];
  List<CustomImageModel> allProductImages = [];
  List<String> deletedImageIds = [];

  File? _featuredImage;

  File? get featuredImage => _featuredImage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void pickProductImages() async {
    try {
      final images =
          await _picker.pickMultiImage(maxWidth: 2000, maxHeight: 2000);
      if (images == null) return;
      for (XFile image in images) {
        var imagesTemporary = File(image.path);
        newProductImages.add(CustomImageModel(
            imageId: DateTime.now().toString(), image: imagesTemporary));
        setAllProductImages();
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

  setAllProductImages() {
    allProductImages = [...productImages, ...newProductImages];
    Logger.i('All Product Images: $allProductImages');
    notifyListeners();
  }

  void addOldImage(CustomImageModel imageModel) {
    productImages.add(
        CustomImageModel(imageId: imageModel.imageId, image: imageModel.image));
    setAllProductImages();
    notifyListeners();
  }

  void removeFeaturedImage() {
    _featuredImage = null;
    notifyListeners();
  }

  void removeImage(int index, String id) {
    if (id.length < 10) {
      deletedImageIds.add(id);
      Logger.i('Deleted Image Ids: $deletedImageIds');
    }
    newProductImages.removeWhere((i) => i.imageId == id);
    productImages.removeWhere((i) => i.imageId == id);
    setAllProductImages();
    notifyListeners();
  }

  void clearDeletedImageIds() {
    deletedImageIds.clear();
    notifyListeners();
  }

  void clearAllImages() {
    productImages.clear();
    newProductImages.clear();
    allProductImages.clear();
    _featuredImage = null;
    notifyListeners();
  }
}
