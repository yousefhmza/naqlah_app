import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/spaces.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/custom_icons.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../components/settings/location_info_component.dart';
import '../components/settings/user_info_component.dart';
import '../components/store_info_component.dart';
import '../widgets/primary_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: PrimaryAppbar(
        title: AppStrings.settings,
        leading: CustomIcons.iconly_light_outline_arrow___left_circle,
        onLeadingTapped: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.all(AppPadding.p16.w).copyWith(bottom: AppPadding.p0),
        child: Column(
          children: [
            const StoreInfoComponent(roundedCorners: true),
            VerticalSpace(deviceHeight * 0.03),
            const UserInfoComponent(),
            VerticalSpace(deviceHeight * 0.03),
            const LocationInfoComponent(),
            VerticalSpace(deviceHeight * 0.03),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                child: const CustomText(AppStrings.modificationRequest),
                color: AppColors.primary,
                isRounded: false,
                isOutlined: false,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
