import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core/services/error/failure.dart';
import '../models/user_model.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, String>> sendOTP(
      String phoneNumber, String appSignature);

  Future<Either<Failure, User>> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String userType,
    required String storeName,
    required String storeAddress,
    required String storeCityId,
    required String storeGovernorateId,
  });

  Future<Either<Failure, User>> login({
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, String>> forgetPassword({
    required String phoneNumber,
  });

  Future<void> logout(BuildContext context);
}
