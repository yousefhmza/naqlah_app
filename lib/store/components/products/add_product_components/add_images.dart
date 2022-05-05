import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/view_model/products_view_model/products_states.dart';
import '../../../../common/view_model/products_view_model/products_view_model.dart';
import '../../../../core/widgets/custom_icon.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/spaces.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../widgets/add_product_item.dart';

class AddImages extends StatelessWidget {
  final ProductsViewModel _storeProductsVM;

  const AddImages(this._storeProductsVM, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddProductItem(
      title: AppStrings.addImages,
      body: BlocBuilder<ProductsViewModel, ProductsStates>(
        buildWhen: (context, state) => state is ProductsPickImagesState,
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: deviceWidth * 0.02,
              runSpacing: deviceWidth * 0.02,
              children: [
                for (var image in _storeProductsVM.selectedImages)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s16.r),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: deviceWidth * 0.28,
                      height: deviceWidth * 0.28,
                    ),
                  ),
                if (_storeProductsVM.selectedImages.length < 5)
                  GestureDetector(
                    onTap: () async {
                      await _storeProductsVM.addImages();
                    },
                    child: Container(
                      width: deviceWidth * 0.28,
                      height: deviceWidth * 0.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s16.r),
                        border: Border.all(
                          color: AppColors.grey,
                          width: AppSize.s1_5.w,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomIcon(
                            Icons.add_circle_outline,
                            color: AppColors.grey,
                          ),
                          VerticalSpace(deviceHeight * 0.01),
                          const CustomText(
                            AppStrings.addImages,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
