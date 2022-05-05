import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_text.dart';
import '../../core/utils/globals.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/values_manager.dart';

class StoreInfoComponent extends StatelessWidget {
  final bool roundedCorners;

  const StoreInfoComponent({
    this.roundedCorners = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: roundedCorners
          ? BorderRadius.circular(AppSize.s24.r)
          : BorderRadius.circular(AppSize.s0),
      child: Container(
        height: deviceHeight * 0.3,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppImages.authMethodBG),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppPadding.p16.w),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.black, AppColors.transparent],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  currentUser.storeName,
                  color: AppColors.white,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.medium,
                  height: AppSize.s1_5.h,
                ),
                CustomText(
                  currentUser.name,
                  color: AppColors.white,
                  height: AppSize.s1_5.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
