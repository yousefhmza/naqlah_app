import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/components/products/empty_list.dart';
import '../../common/view_model/products_view_model/products_states.dart';
import '../../common/view_model/products_view_model/products_view_model.dart';
import '../../common/widgets/loading_list.dart';
import '../../common/widgets/primary_appbar.dart';
import '../../core/components/retry_component.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/platform_widgets/loading_spinner.dart';
import '../../core/widgets/spaces.dart';
import '../../core/widgets/status_bar.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/custom_icons.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../../core/utils/alerts.dart';
import '../widgets/my_product_item.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({Key? key}) : super(key: key);

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  late ProductsViewModel _productsVM;

  @override
  void initState() {
    super.initState();
    _productsVM = BlocProvider.of<ProductsViewModel>(context);
    _productsVM.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: PrimaryAppbar(
          title: AppStrings.myProducts,
          leading: CustomIcons.iconly_light_outline_arrow___left_circle,
          onLeadingTapped: () => Navigator.pop(context),
        ),
        body: BlocConsumer<ProductsViewModel, ProductsStates>(
          listener: (context, state) {
            if (state is DeleteProductLoadingState) {
              Alerts.showAppDialog(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LoadingSpinner(hasSmallRadius: false),
                    VerticalSpace(deviceHeight * 0.015),
                    const CustomText(AppStrings.deletingProduct),
                  ],
                ),
              );
            }
            if (state is DeleteProductSuccessState) {
              Navigator.pop(context);
              Alerts.showToast(state.message);
            }
            if (state is DeleteProductFailureState) {
              Alerts.showSnackBar(context, state.failure.message);
            }
          },
          buildWhen: (prevState, state) =>
              state is GetProductsLoadingState ||
              state is GetProductsFailureState ||
              state is GetProductsSuccessState,
          builder: (context, state) {
            return Column(
              children: [
                if (state is GetProductsLoadingState)
                  const Expanded(child: LoadingList()),
                if (state is GetProductsFailureState)
                  Expanded(
                    child: RetryComponent(
                      onRetry: () => _productsVM.getProducts(),
                    ),
                  ),
                if (state is GetProductsSuccessState)
                  Expanded(
                    child: _productsVM.products.isNotEmpty
                        ? AnimatedList(
                            key: _productsVM.listKey,
                            padding: EdgeInsets.all(AppPadding.p16.w),
                            itemBuilder: (context, index, animation) {
                              return MyProductItem(
                                _productsVM.products[index],
                                _productsVM.listKey,
                                animation,
                              );
                            },
                          )
                        : const EmptyList(AppStrings.emptyProducts),
                  ),
                if (state is GetProductsSuccessState &&
                    _productsVM.products.isNotEmpty)
                  Container(
                    height: deviceHeight * 0.08,
                    padding: EdgeInsets.all(AppPadding.p16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey,
                          blurRadius: AppSize.s4.h,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CustomText(state.paginationModel.page.toString()),
                        CustomText(state.paginationModel.limit.toString()),
                        CustomText(state.paginationModel.totalPages.toString()),
                        CustomText(state.paginationModel.totalDocs.toString()),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
