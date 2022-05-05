import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/custom_text.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/values_manager.dart';

class EmptyList extends StatelessWidget {
  final String text;

  const EmptyList(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            AppJson.emptyList,
            width: deviceWidth * 0.5,
            height: deviceWidth * 0.5,
          ),
          CustomText(text, fontSize: FontSize.s16),
        ],
      ),
    );
  }
}
