import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/helpers/products_helper.dart';
import '../../common/models/product_model.dart';
import '../../common/view_model/products_view_model/products_view_model.dart';
import '../../core/widgets/custom_icon.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/spaces.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/custom_icons.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../../core/utils/alerts.dart';

class MyProductItem extends StatelessWidget {
  final Product product;
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> listKey;

  const MyProductItem(
    this.product,
    this.listKey,
    this.animation, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: ProductsHelper.instance.slideAnimation(animation),
      child: FadeTransition(
        opacity: ProductsHelper.instance.opacityAnimation(animation),
        child: Container(
          padding: EdgeInsets.all(AppPadding.p12.w),
          margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSize.s16.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: deviceWidth * 0.25,
                    height: deviceWidth * 0.25,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSize.s12.r),
                    ),
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(AppSize.s12.r),
                  //   child: Image.network(
                  //     product.images[0],
                  //     width: deviceWidth * 0.2,
                  //     height: deviceWidth * 0.2,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  HorizontalSpace(deviceWidth * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          product.name,
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s16,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        VerticalSpace(deviceWidth * 0.02),
                        CustomText(product.category, color: AppColors.grey),
                      ],
                    ),
                  ),
                ],
              ),
              VerticalSpace(deviceHeight * 0.01),
              const Divider(),
              VerticalSpace(deviceHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ProductAction(
                    iconColor: AppColors.text,
                    text: AppStrings.edit,
                    onTap: () {},
                    icon: CustomIcons.iconly_bold_edit,
                  ),
                  Container(
                    color: AppColors.grey,
                    width: AppSize.s1_2.w,
                    height: deviceHeight * 0.03,
                  ),
                  _ProductAction(
                    iconColor: AppColors.error,
                    text: AppStrings.delete,
                    onTap: () {
                      Alerts.showConfirmationDialog(
                        context,
                        title: "Do you want to delete this item?",
                        description: "If you delete it, you can't undo that.",
                        onYes: () => BlocProvider.of<ProductsViewModel>(context)
                            .deleteProduct(product.id),
                      );
                    },
                    icon: CustomIcons.iconly_bold_delete,
                  ),
                  Container(
                    color: AppColors.grey,
                    width: AppSize.s1_2.w,
                    height: deviceHeight * 0.03,
                  ),
                  CustomText(
                    "${product.pricePerUnit} EGP / ${product.priceUnit}",
                    fontWeight: FontWeightManager.medium,
                  ),
                ],
              ),
              VerticalSpace(deviceHeight * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductAction extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ProductAction({
    required this.iconColor,
    required this.onTap,
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CustomIcon(icon, size: FontSize.s18, color: iconColor),
          HorizontalSpace(deviceWidth * 0.01),
          CustomText(text),
        ],
      ),
    );
  }
}
