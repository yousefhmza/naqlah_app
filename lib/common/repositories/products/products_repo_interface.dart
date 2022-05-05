import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/services/error/failure.dart';
import '../../models/pagination_model.dart';
import '../../models/product_model.dart';

abstract class ProductsRepoInterface {
  Future<Either<Failure, Product>> addProduct({
    required String name,
    required String price,
    required String priceUnit,
    required String category,
    required String minAmount,
    required String maxAmount,
    required List<File> images,
  });

  Future<Either<Failure, PaginationModel>> getProducts(
    Map<String, dynamic> params,
  );

  Future<Either<Failure, String>> deleteProduct(String id);
}
