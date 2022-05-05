import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/spaces.dart';
import '../../../core/utils/globals.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resources/values_manager.dart';

class LocationInfoComponent extends StatelessWidget {
  const LocationInfoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.s24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DataItem(
            title: AppStrings.governorate,
            value: currentUser.storeGovernorate.name,
          ),
          const Divider(),
          _DataItem(title: AppStrings.city, value: currentUser.storeCity.name),
          const Divider(),
          _DataItem(
            title: AppStrings.address,
            value: currentUser.storeAddress,
          ),
        ],
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  final String title;
  final String value;

  const _DataItem({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontWeight: FontWeightManager.medium,
          fontSize: FontSize.s16,
        ),
        VerticalSpace(deviceHeight * 0.012),
        CustomText(value),
      ],
    );
  }
}
