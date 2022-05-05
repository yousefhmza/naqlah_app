import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final int? maxLines;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;

  const CustomTextField({
    required this.hintText,
    this.prefix,
    this.suffix,
    this.validator,
    this.readOnly = false,
    this.keyBoardType,
    this.controller,
    this.formatters,
    this.onChanged,
    this.maxLines,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primary,
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      inputFormatters: formatters,
      onChanged: onChanged,
      onTap: onTap,
      keyboardType: keyBoardType,
      maxLines: maxLines,
      style: TextStyle(
        color: AppColors.black,
        fontFamily: FontConstants.englishFontFamily,
        fontSize: FontSize.s16.sp,
        fontWeight: FontWeightManager.regular,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.grey,
          fontSize: FontSize.s14.sp,
          fontFamily: FontConstants.englishFontFamily,
        ),
        contentPadding: EdgeInsets.all(AppPadding.p12.w),
        errorMaxLines: 10,
        errorStyle: TextStyle(
          fontSize: FontSize.s12.sp,
          fontFamily: FontConstants.englishFontFamily,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12.r),
          borderSide:
              BorderSide(color: AppColors.primary, width: AppSize.s1_2.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12.r),
          borderSide: const BorderSide(color: AppColors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12.r),
          borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_2.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12.r),
          borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_2.w),
        ),
        prefixIcon:
            Padding(padding: EdgeInsets.all(AppPadding.p8.w), child: prefix),
        prefixIconConstraints:
            const BoxConstraints(minWidth: AppSize.s0, minHeight: AppSize.s0),
        suffixIcon:
            Padding(padding: EdgeInsets.all(AppPadding.p8.w), child: suffix),
        suffixIconConstraints:
            const BoxConstraints(minWidth: AppSize.s0, minHeight: AppSize.s0),
      ),
    );
  }
}
