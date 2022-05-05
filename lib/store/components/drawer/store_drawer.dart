import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/repositories/auth_repository.dart';
import '../../../common/components/store_info_component.dart';
import '../../../common/helpers/main_helper.dart';
import '../../../core/widgets/custom_icon.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/resources/custom_icons.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/routing/routes.dart';
import 'store_drawer_footer.dart';

class StoreDrawer extends StatelessWidget {
  const StoreDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth * 0.75,
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const StoreInfoComponent(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p16.h),
                  child: Column(
                    children: [
                      _DrawerAction(
                        icon: Icons.add_circle,
                        title: AppStrings.addProd,
                        onTap: () => Navigator.pushNamed(
                            context, Routes.addProductScreen),
                      ),
                      _DrawerAction(
                        icon: CustomIcons.iconly_bold_info_circle,
                        title: AppStrings.helpCenter,
                        onTap: () {},
                      ),
                      _DrawerAction(
                        icon: CustomIcons.iconly_bold_setting,
                        title: AppStrings.settings,
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.settingsScreen),
                      ),
                      _DrawerAction(
                        icon: CustomIcons.iconly_bold_call,
                        title: AppStrings.contactUs,
                        onTap: () async => await MainHelper.instance
                            .launch(AppStrings.callLaunch),
                      ),
                      _DrawerAction(
                        icon: CustomIcons.iconly_bold_logout,
                        title: AppStrings.logout,
                        onTap: () async =>
                            await AuthRepository.instance.logout(context),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(indent: AppSize.s16.w, endIndent: AppSize.s16.w),
              const StoreDrawerFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerAction({
    required this.icon,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CustomIcon(icon),
      horizontalTitleGap: AppSize.s0,
      title: CustomText(title),
    );
  }
}
