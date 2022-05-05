import 'package:flutter/material.dart';

import '../../core/widgets/custom_text.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText("CustomerHomeScreen"),
      ),
    );
  }
}
