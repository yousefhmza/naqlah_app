import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../view_model/signup/signup_states.dart';
import '../view_model/signup/signup_view_model.dart';

class SignupSlider extends StatelessWidget {
  SignupSlider({Key? key}) : super(key: key);

  final double _sliderMaxWidth = deviceWidth - 2 * AppPadding.p16.w;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _sliderMaxWidth,
      height: deviceHeight * 0.01,
      margin: EdgeInsets.symmetric(vertical: AppPadding.p12.h),
      decoration: ShapeDecoration(
        color: AppColors.primary.withOpacity(0.3),
        shape: const StadiumBorder(),
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: BlocSelector<SignupViewModel, SignupStates, int>(
          selector: (_) =>
              BlocProvider.of<SignupViewModel>(context).currentPageIndex,
          builder: (context, pageIndex) => AnimatedContainer(
            width: _sliderMaxWidth * (pageIndex + 1) / 4,
            duration: Time.t700,
            curve: Curves.elasticInOut,
            decoration: const ShapeDecoration(
              color: AppColors.primary,
              shape: StadiumBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
