import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class Sheets {
  static Future<void> showBottomSheet(
    BuildContext context,
    Widget child,
  ) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      constraints: BoxConstraints(maxHeight: deviceHeight * 0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s24.r),
        ),
      ),
      builder: (context) => child,
    );
  }
}
