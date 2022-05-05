import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/services/network/end_points.dart';
import '../../../core/services/error/error_handler.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/services/network/dio_factory.dart';
import '../../models/pagination_model.dart';
import '../../models/product_model.dart';
import 'products_repo_interface.dart';

class ProductsRepository extends ProductsRepoInterface {
  ProductsRepository._privateConstructor();

  static final ProductsRepository instance =
      ProductsRepository._privateConstructor();

  @override
  Future<Either<Failure, Product>> addProduct({
    required String name,
    required String price,
    required String priceUnit,
    required String category,
    required String minAmount,
    required String maxAmount,
    required List<File> images,
  }) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final FormData _requestForm = FormData.fromMap({
          "name": name,
          "price_per_unit": int.tryParse(price),
          "unit": priceUnit,
          // TODO: put real category data
          "category": category,
          "min_amount": int.tryParse(minAmount),
          "max_amount": int.tryParse(maxAmount),
        });
        for (int i = 0; i < images.length; i++) {
          // TODO : this logic isn't the best for uploading only five images as maximum  but i will fix it later
          if (i == 5) {
            break;
          }
          _requestForm.files.add(
            MapEntry(
              "files",
              MultipartFile.fromFileSync(
                images[i].path,
                contentType: MediaType('image', 'jpg'),
              ),
            ),
          );
        }
        final response = await DioFactory.post(
          url: EndPoints.addProduct,
          requestBody: _requestForm,
        );
        return Right(Product.fromJson(response.data["product"]));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, PaginationModel>> getProducts(
    Map<String, dynamic> params,
  ) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await DioFactory.get(
          url: EndPoints.getProduct,
          queryParameters: params,
        );
        return Right(PaginationModel.fromJson(response.data["products"]));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String id) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await DioFactory.delete(
          url: EndPoints.getProduct,
          queryParameters: {"productId": id},
        );
        return Right(response.data["message"]);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
