import '../../../core/network/failure.dart';
import '../../models/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final User user;

  LoginSuccessState(this.user);
}

class LoginFailureState extends LoginStates {
  final Failure failure;

  LoginFailureState(this.failure);
}

class LoginForgetPasswordLoadingState extends LoginStates {}

class LoginForgetPasswordSuccessState extends LoginStates {
  final String message;

  LoginForgetPasswordSuccessState(this.message);
}

class LoginForgetPasswordFailureState extends LoginStates {
  final Failure failure;

  LoginForgetPasswordFailureState(this.failure);
}
