import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/custom_icon.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/platform_widgets/loading_spinner.dart';
import '../../core/widgets/spaces.dart';
import '../../core/widgets/status_bar.dart';
import '../../core/resources/custom_icons.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../../core/utils/alerts.dart';
import '../helpers/login_helper.dart';
import '../view_model/login/login_states.dart';
import '../view_model/login/login_view_model.dart';
import '../widgets/auth_button.dart';
import '../../core/widgets/phone_number_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p16.w),
            child: Form(
              key: LoginHelper.instance.forgetPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CustomIcon(
                        CustomIcons.iconly_light_outline_arrow___left_circle),
                  ),
                  const Spacer(),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          AppStrings.forgetPassword,
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s20,
                        ),
                        VerticalSpace(deviceHeight * 0.02),
                        const CustomText(
                          AppStrings.forgetPasswordDesc,
                          height: AppSize.s1_5,
                        ),
                        VerticalSpace(deviceHeight * 0.02),
                        PhoneNumberTextField(
                          controller: LoginHelper
                              .instance.forgetPasswordPhoneController,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  BlocConsumer<LoginViewModel, LoginStates>(
                    listenWhen: (previousState, state) =>
                        state is LoginForgetPasswordSuccessState ||
                        state is LoginForgetPasswordFailureState,
                    listener: (context, state) {
                      if (state is LoginForgetPasswordSuccessState) {
                        Alerts.showSnackBar(context, state.message,
                            forError: false);
                      }
                      if (state is LoginForgetPasswordFailureState) {
                        Alerts.showSnackBar(context, state.failure.message);
                      }
                    },
                    buildWhen: (previousState, state) =>
                        state is LoginForgetPasswordLoadingState ||
                        state is LoginForgetPasswordSuccessState ||
                        state is LoginForgetPasswordFailureState,
                    builder: (context, state) {
                      return state is LoginForgetPasswordLoadingState
                          ? const LoadingSpinner()
                          : AuthButton(
                              text: AppStrings.confirm,
                              onPressed: () {
                                if (LoginHelper.instance.forgetPasswordFormKey
                                    .currentState!
                                    .validate()) {
                                  FocusScope.of(context).unfocus();
                                  BlocProvider.of<LoginViewModel>(context)
                                      .forgetPassword();
                                }
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
