import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/spaces.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../helpers/add_product_helper.dart';
import '../../../widgets/add_product_item.dart';

class AddAmountsComponent extends StatelessWidget {
  final AddProductHelper _addProductHelper;

  const AddAmountsComponent(this._addProductHelper, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AddProductItem(
            title: AppStrings.minAmount,
            body: CustomTextField(
              hintText: AppStrings.minAmount,
              keyBoardType: TextInputType.number,
              controller: _addProductHelper.prodMinAmountController,
              validator: Validators.minAmountValidator,
              formatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            ),
          ),
        ),
        HorizontalSpace(deviceWidth * 0.04),
        Expanded(
          child: AddProductItem(
            title: AppStrings.maxAmount,
            body: CustomTextField(
              hintText: AppStrings.maxAmount,
              keyBoardType: TextInputType.number,
              controller: _addProductHelper.prodMaxAmountController,
              validator: Validators.maxAmountValidator,
              formatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            ),
          ),
        ),
      ],
    );
  }
}
