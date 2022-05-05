import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/spaces.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../helpers/signup_helper.dart';
import '../../../core/widgets/phone_number_text_field.dart';

class PhoneStep extends StatelessWidget {
  const PhoneStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: SignupHelper.instance.phoneFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                AppStrings.phoneNumber,
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s20,
              ),
              VerticalSpace(deviceHeight * 0.02),
              const CustomText(AppStrings.phoneStepDesc, height: AppSize.s1_5),
              VerticalSpace(deviceHeight * 0.02),
              PhoneNumberTextField(
                controller: SignupHelper.instance.phoneController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
