import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/values_manager.dart';

class TermsAgreement extends StatelessWidget {
  const TermsAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "By signing up you agree to our",
            style: TextStyle(
              color: AppColors.text,
              fontSize: FontSize.s14.sp,
              fontFamily: FontConstants.englishFontFamily,
              fontWeight: FontWeightManager.regular,
              height: AppSize.s1_5.h,
            ),
          ),
          TextSpan(
            text: " privacy policy & terms of service",
            style: TextStyle(
              color: AppColors.text,
              fontSize: FontSize.s14.sp,
              fontFamily: FontConstants.englishFontFamily,
              fontWeight: FontWeightManager.medium,
              height: AppSize.s1_5.h,
            ),
          ),
        ],
      ),
    );
  }
}
