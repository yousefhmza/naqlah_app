import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../auth/models/user_model.dart';
import '../../../core/services/network/end_points.dart';
import '../../../core/services/error/error_handler.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/services/network/dio_factory.dart';
import 'main_repo_interface.dart';

class MainRepository implements MainRepoInterface {
  MainRepository._privateConstructor();

  static final MainRepository instance = MainRepository._privateConstructor();

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await DioFactory.get(url: EndPoints.getCurrentUser);
        return Right(User.fromJson(response.data["user"]));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
