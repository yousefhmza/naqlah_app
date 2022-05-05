import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/view_model/products_view_model/products_view_model.dart';
import '../../common/widgets/primary_appbar.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/spaces.dart';
import '../../core/widgets/status_bar.dart';
import '../../core/resources/custom_icons.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../../core/utils/alerts.dart';
import '../components/products/add_product_components/add_amounts_component.dart';
import '../components/products/add_product_components/add_button.dart';
import '../components/products/add_product_components/add_images.dart';
import '../components/products/add_product_components/add_price_component.dart';
import '../helpers/add_product_helper.dart';
import '../widgets/add_product_item.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late final ProductsViewModel _storeProductsVM;
  final AddProductHelper _addProductHelper = AddProductHelper.instance;

  @override
  void initState() {
    _storeProductsVM = BlocProvider.of<ProductsViewModel>(context);
    _addProductHelper.initControllers();
    super.initState();
  }

  @override
  void dispose() {
    _addProductHelper.disposeControllers();
    _storeProductsVM.resetSelectedImages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_addProductHelper.filledSomeData()) {
          Alerts.showConfirmationDialog(
            context,
            title: AppStrings.confirmationQuestion,
            description: AppStrings.addedDataAlert,
            onYes: () => Navigator.pop(context),
          );
        }
        return true;
      },
      child: DarkStatusBar(
        child: Scaffold(
          appBar: PrimaryAppbar(
            title: AppStrings.addProd,
            leading: CustomIcons.iconly_light_outline_arrow___left_circle,
            onLeadingTapped: () {
              if (_addProductHelper.filledSomeData()) {
                Alerts.showConfirmationDialog(
                  context,
                  title: AppStrings.confirmationQuestion,
                  description: AppStrings.addedDataAlert,
                  onYes: () => Navigator.pop(context),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          body: SingleChildScrollView(
            padding:
                EdgeInsets.all(AppPadding.p16.w).copyWith(bottom: AppSize.s0),
            child: Form(
              key: _addProductHelper.addProdFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddImages(_storeProductsVM),
                  VerticalSpace(deviceHeight * 0.05),
                  AddProductItem(
                    title: AppStrings.prodName,
                    body: CustomTextField(
                      hintText: AppStrings.prodName,
                      controller: _addProductHelper.prodNameController,
                      validator: Validators.prodNameValidator,
                    ),
                  ),
                  VerticalSpace(deviceHeight * 0.05),
                  AddPriceComponent(_addProductHelper),
                  VerticalSpace(deviceHeight * 0.05),
                  AddAmountsComponent(_addProductHelper),
                  VerticalSpace(deviceHeight * 0.05),
                  AddProductItem(
                    title: AppStrings.addNotes,
                    body: CustomTextField(
                      hintText: AppStrings.addProductsNotes,
                      maxLines: 8,
                      controller: _addProductHelper.prodNotesController,
                    ),
                  ),
                  VerticalSpace(deviceHeight * 0.05),
                  AddButton(_addProductHelper, _storeProductsVM),
                  VerticalSpace(deviceHeight * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
