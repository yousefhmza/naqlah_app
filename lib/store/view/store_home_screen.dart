import 'package:flutter/material.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/resources/values_manager.dart';
import '../../core/widgets/spaces.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_icon.dart';
import '../../core/widgets/custom_icon_button.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/custom_icons.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/routing/routes.dart';
import '../components/drawer/store_drawer.dart';

class StoreHomeScreen extends StatelessWidget {
  StoreHomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppbar(
        leading: CustomIconButton(
          icon: CustomIcons.iconly_light_outline_category,
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: Center(
        child: CustomButton(
          child: CustomText("My products screen"),
          color: AppColors.primary,
          isRounded: true,
          isOutlined: false,
          onPressed: () =>
              Navigator.pushNamed(context, Routes.myProductsScreen),
        ),
      ),
      drawer: const StoreDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Routes.addProductScreen),
        tooltip: AppStrings.addProd,
        isExtended: true,
        label: Row(
          children: [
            const CustomIcon(Icons.add_circle_outline, color: AppColors.white),
            HorizontalSpace(deviceWidth * 0.02),
            const CustomText(AppStrings.addProd, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}
