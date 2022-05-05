import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  ShimmerWidget.rectangular({
    required this.height,
    this.width = double.infinity,
    Key? key,
  })  : shapeBorder = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        super(key: key);

  const ShimmerWidget.circular({
    required this.height,
    required this.width,
    this.shapeBorder = const CircleBorder(),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey.shade100,
      baseColor: Colors.grey.shade200,
      // direction: ShimmerDirection.ltr,
      child: Container(
        height: height,
        width: width,
        decoration: ShapeDecoration(
          color: AppColors.grey,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
