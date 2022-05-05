import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_text_button.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/platform_widgets/platform_base_widget.dart';
import '../custom_button.dart';
import '../custom_icon.dart';
import '../custom_text.dart';
import '../spaces.dart';

class ConfirmationDialog
    extends PlatformBaseWidget<AlertDialog, CupertinoAlertDialog> {
  final String title;
  final String description;
  final VoidCallback onYes;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onYes,
  }) : super(key: key);

  @override
  CupertinoAlertDialog createCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: CustomText(
        title,
        fontSize: FontSize.s16,
        fontWeight: FontWeightManager.medium,
        textAlign: TextAlign.center,
      ),
      content: CustomText(description, textAlign: TextAlign.center),
      actions: [
        CustomTextButton(
          text: AppStrings.cancel,
          textSize: FontSize.s16,
          onPressed: () => Navigator.pop(context),
        ),
        CustomTextButton(
          text: AppStrings.confirm,
          textSize: FontSize.s16,
          onPressed: () {
            onYes();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  AlertDialog createMaterialWidget(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      contentPadding: EdgeInsets.all(AppPadding.p16.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomText(
                  title,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.medium,
                  height: AppSize.s1_5.h,
                ),
              ),
              HorizontalSpace(deviceWidth * 0.01),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CustomIcon(Icons.close, color: AppColors.grey),
              ),
            ],
          ),
          const Divider(),
          CustomText(description, height: AppSize.s1_5.h),
          VerticalSpace(deviceHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                child: const CustomText(AppStrings.cancel),
                color: AppColors.primary,
                isRounded: false,
                isOutlined: true,
                onPressed: () => Navigator.pop(context),
              ),
              HorizontalSpace(deviceWidth * 0.02),
              CustomButton(
                child: const CustomText(AppStrings.confirm),
                color: AppColors.primary,
                isRounded: false,
                isOutlined: false,
                onPressed: () {
                  onYes();
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
