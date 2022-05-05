import 'dart:io';

import 'package:flutter/material.dart';

class AddProductHelper {
  AddProductHelper._privateConstructor();

  static final AddProductHelper instance =
      AddProductHelper._privateConstructor();

  final List<String> priceUnits = ["Kilo", "Gram", "Box", "Item"];

  final GlobalKey<FormState> addProdFormKey = GlobalKey<FormState>();
  late List<File> _images;
  late TextEditingController prodNameController;
  late TextEditingController prodPriceController;
  late TextEditingController prodPriceUnitController;
  late TextEditingController prodMinAmountController;
  late TextEditingController prodMaxAmountController;
  late TextEditingController prodNotesController;

  void initControllers() {
    _images = [];
    prodNameController = TextEditingController();
    prodPriceController = TextEditingController();
    prodPriceUnitController = TextEditingController();
    prodMinAmountController = TextEditingController();
    prodMaxAmountController = TextEditingController();
    prodNotesController = TextEditingController();
  }

  void disposeControllers() {
    prodNameController.dispose();
    prodPriceController.dispose();
    prodPriceUnitController.dispose();
    prodMinAmountController.dispose();
    prodMaxAmountController.dispose();
    prodNotesController.dispose();
  }

  bool filledSomeData() {
    return _images.isNotEmpty ||
        prodNameController.text.isNotEmpty ||
        prodPriceController.text.isNotEmpty ||
        prodPriceUnitController.text.isNotEmpty ||
        prodMinAmountController.text.isNotEmpty ||
        prodMaxAmountController.text.isNotEmpty ||
        prodNotesController.text.isNotEmpty;
  }

  void onPriceUnitSelected(String priceUnit) {
    prodPriceUnitController.text = priceUnit;
  }

  /// getters
  List<File> get images => _images;

  /// setters
  void setImages(List<File> selectedImages) {
    _images = selectedImages;
  }
}
