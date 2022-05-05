import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/spaces.dart';
import '../../../core/widgets/status_bar.dart';
import '../../core/components/naqlah_logo.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/routing/routes.dart';
import '../widgets/auth_button.dart';

class AuthMethodScreen extends StatelessWidget {
  const AuthMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.authMethodBG),
            ),
          ),
          child: Container(
            height: deviceHeight,
            width: deviceWidth,
            padding: EdgeInsets.all(AppPadding.p16.w),
            decoration: BoxDecoration(color: AppColors.black.withOpacity(0.5)),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const NaqlahLogo(),
                      VerticalSpace(deviceHeight * 0.01),
                      const CustomText(
                        "Your way to reach supplies easily",
                        color: AppColors.white,
                        fontSize: FontSize.s16,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const CustomText(
                  "Welcome to NaQlah!",
                  fontWeight: FontWeightManager.medium,
                  fontSize: FontSize.s20,
                  color: AppColors.white,
                ),
                VerticalSpace(deviceHeight * 0.01),
                CustomText(
                  "Your best and fastest way to get supplies needed for your restaurant or home.",
                  textAlign: TextAlign.center,
                  fontSize: FontSize.s12,
                  color: AppColors.white,
                  height: AppSize.s1_2,
                ),
                VerticalSpace(deviceHeight * 0.04),
                AuthButton(
                  text: AppStrings.login,
                  buttonColor: AppColors.secondary,
                  textColor: AppColors.white,
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.loginScreen),
                ),
                VerticalSpace(deviceHeight * 0.02),
                AuthButton(
                  text: AppStrings.signup,
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.signupScreen),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
