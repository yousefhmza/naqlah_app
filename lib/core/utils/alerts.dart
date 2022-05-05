import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/custom_text.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';
import '../widgets/platform_widgets/confirmation_dialog.dart';

// Snack bars, toasts and dialogs
class Alerts {
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool forError = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          message,
          color: AppColors.white,
          fontSize: FontSize.s16,
        ),
        backgroundColor: forError ? AppColors.error : AppColors.text,
      ),
    );
  }

  static void showToast(
    String message, [
    ToastGravity toastGravity = ToastGravity.BOTTOM,
  ]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: FontSize.s16.sp,
      backgroundColor: AppColors.lightGrey,
      textColor: AppColors.text,
    );
  }

  static void showAppDialog(BuildContext context, Widget content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16.r),
        ),
        contentPadding: EdgeInsets.all(AppPadding.p12.w),
        content: content,
      ),
    );
  }

  static void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onYes,
  }) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        description: description,
        onYes: onYes,
      ),
    );
  }
}
