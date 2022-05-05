import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'platform_base_widget.dart';
import '../../resources/values_manager.dart';

class LoadingSpinner extends PlatformBaseWidget<Center, Center> {
  final bool hasSmallRadius;
  final double _radius;
  final double _strokeWidth;

  const LoadingSpinner({this.hasSmallRadius = true, Key? key})
      : _radius = hasSmallRadius ? AppSize.s12 : AppSize.s24,
        _strokeWidth = hasSmallRadius ? AppSize.s2 : AppSize.s3,
        super(key: key);

  @override
  Center createCupertinoWidget(BuildContext context) {
    return Center(child: CupertinoActivityIndicator(radius: _radius.r));
  }

  @override
  Center createMaterialWidget(BuildContext context) {
    return Center(
      child: SizedBox(
        height: _radius.r,
        width: _radius.r,
        child: CircularProgressIndicator(strokeWidth: _strokeWidth.w),
      ),
    );
  }
}
