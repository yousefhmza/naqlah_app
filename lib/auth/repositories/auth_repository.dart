import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/services/network/end_points.dart';
import '../../core/services/dependency_inj.dart';
import '../../core/services/cache_factory.dart';
import '../../core/services/error/error_handler.dart';
import '../../core/routing/routes.dart';
import '../../core/services/error/failure.dart';
import '../../core/services/network/dio_factory.dart';
import '../../core/utils/storage_keys.dart';
import '../models/user_model.dart';
import 'auth_repo_interface.dart';

class AuthRepository implements AuthRepositoryInterface {
  AuthRepository._private();

  static final AuthRepository instance = AuthRepository._private();

  @override
  Future<Either<Failure, String>> sendOTP(
    String phoneNumber,
    String appSignature,
  ) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await DioFactory.update(
          url: EndPoints.sendOtp,
          requestBody: {
            "phone_number": phoneNumber,
            "app_signature": appSignature,
          },
        );
        return Right(response.data["otp"]);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String userType,
    required String storeName,
    required String storeAddress,
    required String storeCityId,
    required String storeGovernorateId,
  }) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await DioFactory.post(
          url: EndPoints.signup,
          requestBody: {
            "name": name.trim(),
            "phone_number": phoneNumber.trim(),
            "password": password.trim(),
            "user_type": userType,
            "store_name": storeName.trim(),
            "store_address": storeAddress.trim(),
            "store_city": storeCityId,
            "store_governorate": storeGovernorateId,
          },
        );
        if (response.headers["token"] != null) {
          await CacheFactory.saveSecuredData(
            StorageKeys.token,
            response.headers["token"]![0],
          );
        } else {
          throw Exception();
        }
        return Right(User.fromJson(response.data["user"]));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String phoneNumber,
    required String password,
  }) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await DioFactory.post(
          url: EndPoints.login,
          requestBody: {
            "phone_number": phoneNumber.trim(),
            "password": password.trim(),
          },
        );
        if (response.headers["token"] != null) {
          await CacheFactory.saveSecuredData(
            StorageKeys.token,
            response.headers["token"]![0],
          );
        } else {
          throw Exception();
        }
        return Right(User.fromJson(response.data["user"]));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword({
    required String phoneNumber,
  }) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await DioFactory.update(
          url: EndPoints.forgetPassword,
          requestBody: {"phone_number": phoneNumber},
        );
        return Right(response.data["message"]);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  @override
  Future<void> logout(BuildContext context) async {
    await CacheFactory.deleteSecuredData();
    await CacheFactory.delete(StorageKeys.isAuthed);
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.authMethodScreen,
      (route) => false,
    );
    removeMainVM();
  }
}
