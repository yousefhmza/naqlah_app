import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/repositories/products/products_repo.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/utils/pickers.dart';
import '../../../store/helpers/add_product_helper.dart';
import '../../../store/widgets/my_product_item.dart';
import '../../models/product_model.dart';
import 'products_states.dart';

class ProductsViewModel extends Cubit<ProductsStates> {
  ProductsViewModel() : super(ProductsInitialState());

  /// add products section
  final AddProductHelper _addProductHelper = AddProductHelper.instance;
  final ProductsRepository _productsRepository = ProductsRepository.instance;
  final List<File> _selectedImages = [];

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<File> get selectedImages => _selectedImages;

  void resetSelectedImages() {
    _selectedImages.clear();
  }

  Future<void> addImages() async {
    _selectedImages.addAll(
      await Pickers.instance.pickMultiImages(),
    );
    _addProductHelper.setImages(_selectedImages);
    emit(ProductsPickImagesState());
  }

  Future<void> addProduct() async {
    emit(AddProductLoadingState());
    final result = await _productsRepository.addProduct(
      name: _addProductHelper.prodNameController.text,
      price: _addProductHelper.prodPriceController.text,
      priceUnit: _addProductHelper.prodPriceUnitController.text,
      minAmount: _addProductHelper.prodMinAmountController.text,
      maxAmount: _addProductHelper.prodMaxAmountController.text,
      category: "category",
      images: _addProductHelper.images,
    );
    result.fold(
      (failure) => emit(AddProductFailureState(failure)),
      (product) {
        emit(AddProductSuccessState());
      },
    );
  }

  /// get products section
  final List<Product> products = [];

  Future<void> getProducts() async {
    emit(GetProductsLoadingState());
    (await _productsRepository.getProducts({})).fold(
      (failure) => emit(GetProductsFailureState(failure)),
      (paginationModel) {
        products.clear();
        for (var product in paginationModel.items) {
          products.add(Product.fromJson(product));
        }
        emit(GetProductsSuccessState(paginationModel));
        _animateGetProducts();
      },
    );
  }

  void _animateGetProducts() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var future = Future(() {});
      for (var i = 0; i < products.length; i++) {
        future = future.then((_) {
          return Future.delayed(Time.t100, () {
            listKey.currentState!.insertItem(i);
          });
        });
      }
    });
  }

  /// delete product section
  Future<void> deleteProduct(String id) async {
    emit(DeleteProductLoadingState());
    final result = await _productsRepository.deleteProduct(id);
    result.fold(
      (failure) => emit(DeleteProductFailureState(failure)),
      (message) {
        emit(DeleteProductSuccessState(message));
        _animateDeleteProduct(id);
      },
    );
  }

  void _animateDeleteProduct(String id) {
    final int prodIndex = products.indexWhere((product) => product.id == id);
    final Product removedProd = products.removeAt(prodIndex);
    listKey.currentState!.removeItem(
      prodIndex,
      (context, animation) => MyProductItem(removedProd, listKey, animation),
      duration: Time.t1000,
    );
  }
}
