import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/validators.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';
import '../resources/strings_manager.dart';

class PhoneNumberTextField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberTextField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: AppStrings.phoneNumber,
      keyBoardType: TextInputType.phone,
      controller: controller,
      formatters: [
        LengthLimitingTextInputFormatter(11),
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      prefix: const CustomText("+20"),
      validator: Validators.phoneNumberValidator,
    );
  }
}
