import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/bottom_sheet_indicator.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../helpers/signup_helper.dart';
import '../models/city.dart';
import '../models/governorate.dart';

class AuthBottomSheet extends StatelessWidget {
  final List<dynamic> items;

  const AuthBottomSheet({
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BottomSheetIndicator(),
        Expanded(
          child: items.isEmpty
              ? const Center(child: CustomText(AppStrings.chooseGovAlert))
              : ListView.separated(
                  itemCount: items.length,
                  padding: EdgeInsets.all(AppPadding.p16.w),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (items is List<Governorate>) {
                        SignupHelper.instance
                            .onGovernorateSelected(items[index]);
                      }
                      if (items is List<City>) {
                        SignupHelper.instance.onCitySelected(items[index]);
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: AppPadding.p16.w),
                      child: CustomText(items[index].name),
                    ),
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
        ),
      ],
    );
  }
}
