import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/strings_manager.dart';
import 'alerts.dart';

// image, date or time pickers
class Pickers {
  Pickers._privateConstructor();

  static final Pickers instance = Pickers._privateConstructor();

  Future<File?> pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return null;
      final selectedImage = File(image.path);
      return selectedImage;
    } on PlatformException catch (_) {
      Alerts.showToast(AppStrings.errorMessage);
      return null;
    }
  }

  Future<List<File>> pickMultiImages() async {
    try {
      final List<XFile>? _selectedImages = await ImagePicker().pickMultiImage();
      if (_selectedImages == null) return [];
      final List<File> images = [];
      for (var image in _selectedImages) {
        images.add(File(image.path));
      }
      return images;
    } on PlatformException catch (_) {
      Alerts.showToast(AppStrings.errorMessage);
      return [];
    }
  }
}
