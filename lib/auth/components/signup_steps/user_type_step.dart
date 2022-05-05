import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/spaces.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../helpers/signup_helper.dart';
import '../../models/user_model.dart';
import '../../view_model/signup/signup_states.dart';
import '../../view_model/signup/signup_view_model.dart';

class UserTypeStep extends StatelessWidget {
  const UserTypeStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignupViewModel _signupVM = BlocProvider.of<SignupViewModel>(context);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              AppStrings.userType,
              fontWeight: FontWeightManager.medium,
              fontSize: FontSize.s20,
            ),
            VerticalSpace(deviceHeight * 0.02),
            const CustomText(AppStrings.userTypeDesc, height: AppSize.s1_5),
            VerticalSpace(deviceHeight * 0.02),
            BlocBuilder<SignupViewModel, SignupStates>(
                buildWhen: (context, state) =>
                    state is SignupSelectedUserTypeState,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _UserCard(
                        isChosen: SignupHelper.instance.selectedUserType ==
                            UserType.customer,
                        text: AppStrings.customer,
                        img: AppImages.customer,
                        onTap: () =>
                            _signupVM.setSelectedUserType(UserType.customer),
                      ),
                      _UserCard(
                        isChosen: SignupHelper.instance.selectedUserType ==
                            UserType.seller,
                        text: AppStrings.store,
                        img: AppImages.store,
                        onTap: () =>
                            _signupVM.setSelectedUserType(UserType.seller),
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final bool isChosen;
  final String text;
  final VoidCallback onTap;
  final String img;

  const _UserCard({
    required this.isChosen,
    required this.text,
    required this.onTap,
    required this.img,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppSize.s12.r),
          bottomLeft: Radius.circular(AppSize.s12.r),
        ),
        child: AnimatedContainer(
          duration: Time.t150,
          height: isChosen ? deviceHeight * 0.37 : deviceHeight * 0.35,
          width: isChosen ? deviceWidth * 0.42 : deviceWidth * 0.4,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              color: isChosen ? AppColors.secondary : AppColors.grey,
              width: AppSize.s1_5.w,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s12.r),
              topRight: Radius.circular(AppSize.s12.r),
            ),
          ),
          child: Column(
            children: [
              Expanded(child: Image.asset(img)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppPadding.p12.w),
                alignment: Alignment.center,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: isChosen ? AppColors.secondary : AppColors.grey,
                ),
                child: CustomText(
                  text,
                  fontSize: FontSize.s16,
                  color: isChosen ? AppColors.white : AppColors.text,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
