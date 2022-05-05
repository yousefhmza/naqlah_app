import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final double? width;
  final double? height;
  final bool isRounded;
  final bool isOutlined;
  final bool widerPadding;

  const CustomButton({
    Key? key,
    required this.child,
    required this.color,
    required this.isRounded,
    required this.isOutlined,
    required this.onPressed,
    this.widerPadding = false,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        color: isOutlined ? AppColors.transparent : color,
        highlightElevation: AppSize.s0,
        onPressed: onPressed,
        padding: !widerPadding
            ? EdgeInsets.symmetric(
                vertical: AppPadding.p4.h,
                horizontal: AppPadding.p8.w,
              )
            : EdgeInsets.symmetric(
                vertical: AppPadding.p12.h,
                horizontal: AppPadding.p16.w,
              ),
        elevation: AppSize.s0,
        shape: isRounded
            ? StadiumBorder(
                side: BorderSide(
                  color: color,
                  width: AppSize.s1_5.w,
                ),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12.r),
                side: BorderSide(
                  color: color,
                  width: AppSize.s1_5.w,
                ),
              ),
        child: child,
      ),
    );
  }
}
