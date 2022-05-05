import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/spaces.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_icon.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/utils/globals.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/custom_icons.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/utils/sheets.dart';
import '../../helpers/signup_helper.dart';
import '../../models/city.dart';
import '../../widgets/auth_bottom_sheet.dart';
import '../../widgets/terms_agreement.dart';

class RegisterStep extends StatelessWidget {
  const RegisterStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: SignupHelper.instance.registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                AppStrings.register,
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s20,
              ),
              VerticalSpace(deviceHeight * 0.02),
              const CustomText(
                AppStrings.registerStepDesc,
                height: AppSize.s1_5,
              ),
              const TermsAgreement(),
              VerticalSpace(deviceHeight * 0.02),
              CustomTextField(
                hintText: AppStrings.userName,
                keyBoardType: TextInputType.name,
                controller: SignupHelper.instance.usernameController,
                validator: Validators.userNameValidator,
              ),
              VerticalSpace(deviceHeight * 0.02),
              CustomTextField(
                hintText: AppStrings.storeName,
                keyBoardType: TextInputType.name,
                controller: SignupHelper.instance.storeNameController,
                validator: Validators.storeNameValidator,
              ),
              VerticalSpace(deviceHeight * 0.02),
              CustomTextField(
                hintText: AppStrings.governorate,
                readOnly: true,
                controller: SignupHelper.instance.governorateController,
                onTap: () => Sheets.showBottomSheet(
                  context,
                  AuthBottomSheet(items: governorates),
                ),
                validator: (value) =>
                    SignupHelper.instance.selectedGovernorate?.id == null
                        ? AppStrings.governorateValidator
                        : null,
                suffix: const CustomIcon(
                  CustomIcons.iconly_bold_arrow___down_2,
                  size: FontSize.s16,
                  color: AppColors.textFieldSuffix,
                ),
              ),
              VerticalSpace(deviceHeight * 0.02),
              CustomTextField(
                hintText: AppStrings.city,
                readOnly: true,
                controller: SignupHelper.instance.cityController,
                onTap: () {
                  final List<City> cities = SignupHelper.instance.getCities(
                    SignupHelper.instance.selectedGovernorate?.id ??
                        Constants.empty,
                  );
                  Sheets.showBottomSheet(
                    context,
                    AuthBottomSheet(items: cities),
                  );
                },
                validator: (value) =>
                    SignupHelper.instance.selectedCity?.id == null
                        ? AppStrings.cityValidator
                        : null,
                suffix: const CustomIcon(
                  CustomIcons.iconly_bold_arrow___down_2,
                  size: FontSize.s16,
                  color: AppColors.textFieldSuffix,
                ),
              ),
              VerticalSpace(deviceHeight * 0.02),
              CustomTextField(
                hintText: AppStrings.address,
                keyBoardType: TextInputType.streetAddress,
                controller: SignupHelper.instance.addressController,
                validator: Validators.addressValidator,
              ),
              VerticalSpace(deviceHeight * 0.02),
              CustomTextField(
                hintText: AppStrings.password,
                keyBoardType: TextInputType.visiblePassword,
                controller: SignupHelper.instance.passwordController,
                validator: Validators.passwordValidator,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
