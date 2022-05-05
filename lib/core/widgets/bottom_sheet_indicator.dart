import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class BottomSheetIndicator extends StatelessWidget {
  const BottomSheetIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.01,
      width: deviceWidth * 0.3,
      margin: EdgeInsets.symmetric(vertical: AppPadding.p8.h),
      decoration: const ShapeDecoration(
        color: AppColors.lightGrey,
        shape: StadiumBorder(),
      ),
    );
  }
}
