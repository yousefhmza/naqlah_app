import 'package:flutter/material.dart';

import '../../core/widgets/custom_text.dart';
import '../../core/widgets/spaces.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/values_manager.dart';

class AddProductItem extends StatelessWidget {
  final String title;
  final Widget body;

  const AddProductItem({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontSize: FontSize.s16,
          fontWeight: FontWeightManager.medium,
        ),
        VerticalSpace(deviceHeight * 0.02),
        body,
      ],
    );
  }
}
