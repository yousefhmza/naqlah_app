import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/spaces.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../view_model/signup/signup_view_model.dart';

class OTPStep extends StatefulWidget {
  const OTPStep({Key? key}) : super(key: key);

  @override
  State<OTPStep> createState() => _OTPStepState();
}

class _OTPStepState extends State<OTPStep> {
  late final SignupViewModel _signupVM;

  @override
  void initState() {
    _signupVM = BlocProvider.of<SignupViewModel>(context);
    Timer(
      Time.t1000,
      () async {
        await SmsAutoFill().listenForCode();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    Timer(
      Time.t0,
      () async {
        await SmsAutoFill().unregisterListener();
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              AppStrings.otp,
              fontWeight: FontWeightManager.medium,
              fontSize: FontSize.s20,
            ),
            VerticalSpace(deviceHeight * 0.02),
            const CustomText(AppStrings.otpStepDesc, height: AppSize.s1_5),
            VerticalSpace(deviceHeight * 0.02),
            PinFieldAutoFill(
              codeLength: 6,
              keyboardType: TextInputType.number,
              onCodeChanged: (code) => code != null && code.isNotEmpty
                  ? _signupVM.toUserTypePage(code)
                  : null,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
              ],
              decoration: BoxLooseDecoration(
                gapSpace: AppSize.s12,
                strokeWidth: AppSize.s1_2.w,
                bgColorBuilder: const FixedColorBuilder(AppColors.lightGrey),
                strokeColorBuilder:
                    const FixedColorBuilder(AppColors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
