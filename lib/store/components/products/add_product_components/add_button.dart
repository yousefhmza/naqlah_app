import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/view_model/products_view_model/products_states.dart';
import '../../../../common/view_model/products_view_model/products_view_model.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/platform_widgets/loading_spinner.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/alerts.dart';
import '../../../helpers/add_product_helper.dart';

class AddButton extends StatelessWidget {
  final AddProductHelper _addProductHelper;
  final ProductsViewModel _storeProductsVM;

  const AddButton(
    this._addProductHelper,
    this._storeProductsVM, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsViewModel, ProductsStates>(
      listenWhen: (prevState, state) =>
          state is AddProductSuccessState || state is AddProductFailureState,
      listener: (context, state) {
        if (state is AddProductSuccessState) {
          Alerts.showToast(AppStrings.productAdded);
          Navigator.pop(context);
        }
        if (state is AddProductFailureState) {
          Alerts.showSnackBar(context, state.failure.message);
        }
      },
      buildWhen: (prevState, state) =>
          state is AddProductLoadingState ||
          state is AddProductSuccessState ||
          state is AddProductFailureState,
      builder: (context, state) => state is AddProductLoadingState
          ? const LoadingSpinner()
          : CustomButton(
              child: const CustomText(AppStrings.add),
              color: AppColors.primary,
              isRounded: false,
              widerPadding: true,
              isOutlined: false,
              onPressed: () {
                if (_addProductHelper.addProdFormKey.currentState!.validate() &&
                    _addProductHelper.images.isNotEmpty) {
                  _storeProductsVM.addProduct();
                }
                if (_addProductHelper.images.isEmpty) {
                  Alerts.showSnackBar(
                    context,
                    AppStrings.prodImagesValidator,
                  );
                }
              },
            ),
    );
  }
}
