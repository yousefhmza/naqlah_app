import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_icon.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/status_bar.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/custom_icons.dart';
import '../../../core/resources/values_manager.dart';
import '../../core/widgets/platform_widgets/loading_spinner.dart';
import '../../core/services/dependency_inj.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/utils/alerts.dart';
import '../helpers/login_helper.dart';
import '../helpers/signup_helper.dart';
import '../view_model/signup/signup_states.dart';
import '../view_model/signup/signup_view_model.dart';
import '../widgets/auth_button.dart';
import '../widgets/signup_slider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final SignupViewModel _signupVM;
  final SignupHelper _signupHelper = SignupHelper.instance;

  @override
  void initState() {
    _signupVM = BlocProvider.of<SignupViewModel>(context);
    _signupHelper.initControllers();
    super.initState();
  }

  @override
  void dispose() {
    _signupHelper.disposeControllers();
    removeSignupVM();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CustomIcon(
                    CustomIcons.iconly_light_outline_arrow___left_circle,
                  ),
                ),
                SignupSlider(),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    padding: EdgeInsets.all(AppPadding.p8.w),
                    decoration: const ShapeDecoration(
                      color: AppColors.secondary,
                      shape: StadiumBorder(),
                    ),
                    child: BlocSelector<SignupViewModel, SignupStates, int>(
                      selector: (_) => _signupVM.currentPageIndex,
                      builder: (context, pageIndex) => CustomText(
                        "${pageIndex + 1}/${_signupHelper.signupSteps.length}",
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _signupHelper.pageController,
                    itemCount: _signupHelper.signupSteps.length,
                    itemBuilder: (context, index) =>
                        _signupHelper.signupSteps[_signupVM.currentPageIndex],
                  ),
                ),
                BlocConsumer<SignupViewModel, SignupStates>(
                  listener: (context, state) {
                    if (state is SignupSuccessState) {
                      LoginHelper.instance
                          .afterAuth(context, true, state.user.id);
                    }
                    if (state is SignupFailureState) {
                      Alerts.showSnackBar(context, state.failure.message);
                    }
                  },
                  builder: (context, state) {
                    return state is SignupLoadingState
                        ? const LoadingSpinner()
                        : AuthButton(
                            text: _signupVM.currentPageIndex < 3
                                ? AppStrings.goOn
                                : AppStrings.signup,
                            onPressed: () {
                              switch (_signupVM.currentPageIndex) {
                                case 0:
                                  _signupVM.sendOTP();
                                  break;
                                case 1:
                                  break;
                                case 2:
                                  _signupVM.toRegisterPage();
                                  break;
                                case 3:
                                  _signupVM.register();
                                  break;
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
    );
  }
}
