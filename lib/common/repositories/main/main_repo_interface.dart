import 'package:dartz/dartz.dart';

import '../../../auth/models/user_model.dart';
import '../../../core/network/failure.dart';

abstract class MainRepoInterface {
  Future<Either<Failure, User>> getCurrentUser();
}
