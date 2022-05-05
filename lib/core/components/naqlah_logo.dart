import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/font_manager.dart';
import '../resources/color_manager.dart';

class NaqlahLogo extends StatelessWidget {
  final bool reverseColor;

  const NaqlahLogo({this.reverseColor = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "NaQl",
            style: TextStyle(
              color: reverseColor ? AppColors.white : AppColors.primary,
              fontSize: FontSize.s48.sp,
              fontFamily: FontConstants.englishFontFamily,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          TextSpan(
            text: "ah",
            style: TextStyle(
              color: AppColors.text,
              fontSize: FontSize.s48.sp,
              fontFamily: FontConstants.englishFontFamily,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ],
      ),
    );
  }
}
