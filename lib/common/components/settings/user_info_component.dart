import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_icon.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/utils/globals.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/custom_icons.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/values_manager.dart';

class UserInfoComponent extends StatelessWidget {
  const UserInfoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.s24.r),
      ),
      child: ListTile(
        onTap: () {},
        contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
        horizontalTitleGap: AppSize.s0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [CustomIcon(CustomIcons.iconly_bold_profile)],
        ),
        title: CustomText(
          currentUser.name,
          fontWeight: FontWeightManager.medium,
          fontSize: FontSize.s16,
        ),
        subtitle: CustomText(currentUser.phoneNumber),
        trailing: const CustomIcon(
          CustomIcons.iconly_bold_arrow___down_circle,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
