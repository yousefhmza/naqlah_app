import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/spaces.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class RetryComponent extends StatelessWidget {
  final VoidCallback onRetry;

  const RetryComponent({required this.onRetry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: deviceHeight * 0.3,
              child: Image.asset(
                AppImages.store,
                fit: BoxFit.cover,
              ),
            ),
            VerticalSpace(deviceHeight * 0.03),
            CustomText(
              AppStrings.errorMessage,
              textAlign: TextAlign.center,
              height: AppSize.s1_5.h,
              color: AppColors.grey,
            ),
            VerticalSpace(deviceHeight * 0.03),
            SizedBox(
              width: deviceWidth * 0.4,
              child: CustomButton(
                color: AppColors.primary,
                isRounded: true,
                isOutlined: true,
                onPressed: onRetry,
                child: const CustomText("Retry"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
