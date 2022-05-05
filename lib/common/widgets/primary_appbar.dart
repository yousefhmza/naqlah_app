import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_icon_button.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/font_manager.dart';

class PrimaryAppbar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final IconData leading;
  final VoidCallback onLeadingTapped;

  const PrimaryAppbar({
    required this.title,
    required this.leading,
    required this.onLeadingTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      bgColor: AppColors.primary,
      centerTitle: true,
      title: CustomText(
        title,
        fontSize: FontSize.s18,
        fontWeight: FontWeightManager.medium,
      ),
      leading: CustomIconButton(
        icon: leading,
        onPressed: onLeadingTapped,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
