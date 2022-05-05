import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/utils/storage_keys.dart';
import '../../core/widgets/custom_icon.dart';
import '../../core/network/cache_factory.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/custom_text_button.dart';
import '../../core/widgets/spaces.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/custom_icons.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../../core/routing/routes.dart';
import '../models/on_boarding_model.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  final List<OnBoardingModel> _onBoardingPages = [
    OnBoardingModel(
      AppStrings.onBoardingTitle1,
      AppStrings.onBoardingDesc1,
      AppImages.onBoarding1,
    ),
    OnBoardingModel(
      AppStrings.onBoardingTitle2,
      AppStrings.onBoardingDesc2,
      AppImages.onBoarding2,
    ),
    OnBoardingModel(
      AppStrings.onBoardingTitle3,
      AppStrings.onBoardingDesc3,
      AppImages.onBoarding3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: PopupMenuButton(
          color: AppColors.lightGrey,
          elevation: AppSize.s0,
          shape: OutlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(AppSize.s24.r),
          ),
          icon: const CustomIcon(CustomIcons.iconly_light_outline_setting),
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {},
              child: const CustomText(AppStrings.arabic),
            ),
            PopupMenuItem(
              onTap: () {},
              child: const CustomText(AppStrings.english),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(AppPadding.p16.w).copyWith(top: AppPadding.p0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onBoardingPages.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SvgPicture.asset(_onBoardingPages[index].img),
                    ),
                    VerticalSpace(deviceHeight * 0.02),
                    CustomText(
                      _onBoardingPages[index].title,
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s24,
                      color: AppColors.secondary,
                    ),
                    VerticalSpace(deviceHeight * 0.02),
                    CustomText(
                      _onBoardingPages[index].desc,
                      fontSize: FontSize.s16,
                      height: AppSize.s1_5,
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpace(deviceHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  effect: WormEffect(
                    dotWidth: AppSize.s8,
                    dotHeight: AppSize.s8,
                    activeDotColor: AppColors.secondary,
                    dotColor: AppColors.secondary.withOpacity(0.3),
                  ),
                  controller: _pageController,
                  count: _onBoardingPages.length,
                ),
                CustomTextButton(
                  text: AppStrings.skip,
                  textColor: AppColors.primary,
                  textSize: FontSize.s16,
                  onPressed: () async {
                    await CacheFactory.save(StorageKeys.isOnBoardingSeen, true);
                    Navigator.pushReplacementNamed(
                        context, Routes.authMethodScreen);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
