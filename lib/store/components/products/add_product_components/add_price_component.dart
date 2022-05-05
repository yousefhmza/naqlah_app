import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/bottom_sheet_indicator.dart';
import '../../../../core/widgets/custom_icon.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/spaces.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/custom_icons.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/sheets.dart';
import '../../../helpers/add_product_helper.dart';
import '../../../widgets/add_product_item.dart';

class AddPriceComponent extends StatelessWidget {
  final AddProductHelper _addProductHelper;

  const AddPriceComponent(this._addProductHelper, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AddProductItem(
            title: AppStrings.price,
            body: CustomTextField(
              hintText: AppStrings.prodPrice,
              keyBoardType: TextInputType.number,
              controller: _addProductHelper.prodPriceController,
              validator: Validators.priceValidator,
              formatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              suffix: const CustomText(AppStrings.egp),
            ),
          ),
        ),
        HorizontalSpace(deviceWidth * 0.04),
        Expanded(
          child: AddProductItem(
            title: AppStrings.priceUnit,
            body: CustomTextField(
              hintText: AppStrings.priceUnit,
              readOnly: true,
              controller: _addProductHelper.prodPriceUnitController,
              onTap: () => Sheets.showBottomSheet(
                context,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BottomSheetIndicator(),
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
                        child: CustomScrollView(
                          shrinkWrap: true,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _addProductHelper.onPriceUnitSelected(
                                              _addProductHelper
                                                  .priceUnits[index]);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              vertical: AppPadding.p16.w),
                                          child: CustomText(_addProductHelper
                                              .priceUnits[index]),
                                        ),
                                      ),
                                      if (index !=
                                          _addProductHelper.priceUnits.length -
                                              1)
                                        const Divider(),
                                    ],
                                  );
                                },
                                childCount: _addProductHelper.priceUnits.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              validator: Validators.priceUnitValidator,
              suffix: const CustomIcon(
                CustomIcons.iconly_bold_arrow___down_2,
                size: FontSize.s16,
                color: AppColors.textFieldSuffix,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
