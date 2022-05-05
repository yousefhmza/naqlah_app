import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/helpers/main_helper.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resources/values_manager.dart';

class StoreDrawerFooter extends StatelessWidget {
  const StoreDrawerFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: AppPadding.p8.h,
            bottom: AppPadding.p16.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SocialMediaItem(
                icon: AppImages.facebook,
                onTap: () async =>
                    await MainHelper.instance.launch(AppStrings.facebookLink),
              ),
              _SocialMediaItem(
                icon: AppImages.whatsapp,
                onTap: () async =>
                    await MainHelper.instance.launch(AppStrings.whatsappLink),
              ),
              _SocialMediaItem(
                icon: AppImages.linkedin,
                onTap: () async =>
                    await MainHelper.instance.launch(AppStrings.linkedinLink),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: AppPadding.p8.w),
          child: const CustomText(AppStrings.version, color: AppColors.grey),
        ),
      ],
    );
  }
}

class _SocialMediaItem extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const _SocialMediaItem({
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(icon, width: deviceWidth * 0.1),
    );
  }
}
