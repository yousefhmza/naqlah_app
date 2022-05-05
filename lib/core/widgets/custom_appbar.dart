import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Color bgColor;
  final bool hasDarkStatusBar;

  const CustomAppbar({
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.bgColor = AppColors.white,
    this.centerTitle = false,
    this.hasDarkStatusBar = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      actions: actions,
      backgroundColor: bgColor,
      elevation: AppSize.s0,
      centerTitle: centerTitle,
      bottom: bottom,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness:
            hasDarkStatusBar ? Brightness.dark : Brightness.light,
        statusBarBrightness:
            hasDarkStatusBar ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
