import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_text.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../core/resources/values_manager.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const AuthButton({
    required this.text,
    this.onPressed,
    this.buttonColor = AppColors.primary,
    this.textColor = AppColors.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        color: buttonColor,
        highlightElevation: AppSize.s0,
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p12.h,
          horizontal: AppPadding.p16.w,
        ),
        elevation: AppSize.s0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12.r),
        ),
        disabledColor: AppColors.grey,
        child: CustomText(
          text,
          fontWeight: FontWeightManager.medium,
          fontSize: FontSize.s16.sp,
          color: textColor,
        ),
      ),
    );
  }
}
