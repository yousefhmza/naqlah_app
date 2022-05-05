import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/shimmer_widget.dart';
import '../../core/widgets/spaces.dart';
import '../../core/resources/values_manager.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(AppPadding.p16.w),
      itemCount: 3,
      itemBuilder: (_, __) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShimmerWidget.rectangular(
            height: deviceWidth * 0.25,
            width: deviceWidth * 0.25,
          ),
          HorizontalSpace(deviceWidth * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rectangular(height: deviceHeight * 0.02),
                VerticalSpace(deviceHeight * 0.02),
                ShimmerWidget.rectangular(
                  height: deviceHeight * 0.015,
                  width: deviceWidth * 0.4,
                ),
              ],
            ),
          ),
        ],
      ),
      separatorBuilder: (_, __) => VerticalSpace(deviceHeight * 0.02),
    );
  }
}
