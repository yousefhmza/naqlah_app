import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformBaseWidget<A extends Widget, I extends Widget>
    extends StatelessWidget {
  const PlatformBaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? createMaterialWidget(context)
        : createCupertinoWidget(context);
  }

  A createMaterialWidget(BuildContext context);

  I createCupertinoWidget(BuildContext context);
}
