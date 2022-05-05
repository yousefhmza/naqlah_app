import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'values_manager.dart';
import 'color_manager.dart';

class ThemeManager {
  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        dividerColor: AppColors.grey,
        listTileTheme: const ListTileThemeData(dense: true),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          elevation: AppSize.s4.h,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
        ),
      );
}
