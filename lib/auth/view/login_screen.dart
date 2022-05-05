import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/validators.dart';
import '../../core/widgets/platform_widgets/loading_spinner.dart';
import '../../core/services/dependency_inj.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/spaces.dart';
import '../../../core/widgets/status_bar.dart';
import '../../core/components/naqlah_logo.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../core/widgets/custom_icon.dart';
import '../../core/resources/custom_icons.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/alerts.dart';
import '../helpers/login_helper.dart';
import '../view_model/login/login_states.dart';
import '../view_model/login/login_view_model.dart';
import '../widgets/auth_button.dart';
import '../../core/widgets/phone_number_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginViewModel _loginVM;
  final LoginHelper _loginHelper = LoginHelper.instance;

  @override
  void initState() {
    _loginVM = BlocProvider.of<LoginViewModel>(context);
    _loginHelper.initControllers();
    super.initState();
  }

  @override
  void dispose() {
    _loginHelper.disposeControllers();
    removeLoginVM();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.all(AppPadding.p16.w),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CustomIcon(
                    CustomIcons.iconly_light_outline_arrow___left_circle,
                    color: AppColors.white,
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: NaqlahLogo(reverseColor: true),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p16.w,
                  vertical: AppPadding.p24.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSize.s24.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginHelper.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PhoneNumberTextField(
                          controller: _loginHelper.phoneController,
                        ),
                        VerticalSpace(deviceHeight * 0.02),
                        CustomTextField(
                          hintText: AppStrings.password,
                          keyBoardType: TextInputType.visiblePassword,
                          controller: _loginHelper.passwordController,
                          validator: Validators.passwordValidator,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: CustomTextButton(
                            text: AppStrings.forgetPassword,
                            onPressed: () => Navigator.pushNamed(
                              context,
                              Routes.forgetPasswordScreen,
                            ),
                          ),
                        ),
                        VerticalSpace(deviceHeight * 0.02),
                        BlocConsumer<LoginViewModel, LoginStates>(
                          listenWhen: (previousState, state) =>
                              state is LoginSuccessState ||
                              state is LoginFailureState,
                          listener: (context, state) {
                            if (state is LoginSuccessState) {
                              _loginHelper.afterAuth(
                                  context, false, state.user.id);
                            }
                            if (state is LoginFailureState) {
                              Alerts.showSnackBar(
                                  context, state.failure.message);
                            }
                          },
                          buildWhen: (previousState, state) =>
                              state is LoginLoadingState ||
                              state is LoginSuccessState ||
                              state is LoginFailureState,
                          builder: (context, state) {
                            return state is LoginLoadingState
                                ? const LoadingSpinner()
                                : AuthButton(
                                    text: AppStrings.login,
                                    onPressed: () {
                                      if (_loginHelper
                                          .loginFormKey.currentState!
                                          .validate()) {
                                        FocusScope.of(context).unfocus();
                                        _loginVM.login();
                                      }
                                    },
                                  );
                          },
                        ),
                        VerticalSpace(deviceHeight * 0.02),
                        Row(
                          children: [
                            const CustomText(AppStrings.suggestLogin),
                            HorizontalSpace(deviceWidth * 0.04),
                            CustomTextButton(
                              text: AppStrings.signup,
                              textColor: AppColors.primary,
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, Routes.signupScreen),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
