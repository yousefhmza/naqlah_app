import '../../../core/services/error/failure.dart';
import '../../models/user_model.dart';

abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class SignupSetCurrentPageIndexState extends SignupStates {}

class SignupSelectedUserTypeState extends SignupStates {}

class SignupLoadingState extends SignupStates {}

class SignupSuccessState extends SignupStates {
  final User user;

  SignupSuccessState(this.user);
}

class SignupFailureState extends SignupStates {
  final Failure failure;

  SignupFailureState(this.failure);
}
