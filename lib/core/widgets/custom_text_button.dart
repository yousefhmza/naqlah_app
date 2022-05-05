import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double textSize;
  final FontWeight fontWeight;
  final Color textColor;

  const CustomTextButton({
    this.onPressed,
    required this.text,
    this.textColor = AppColors.text,
    this.fontWeight = FontWeightManager.medium,
    this.textSize = FontSize.s14,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(primary: AppColors.secondary),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: CustomText(
          text,
          color: textColor,
          fontSize: textSize.sp,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
