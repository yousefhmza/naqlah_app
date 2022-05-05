import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/login_helper.dart';
import '../../repositories/auth_repository.dart';
import 'login_states.dart';

class LoginViewModel extends Cubit<LoginStates> {
  LoginViewModel() : super(LoginInitialState());

  final LoginHelper _loginHelper = LoginHelper.instance;
  final AuthRepository _authRepository = AuthRepository.instance;

  Future<void> login() async {
    emit(LoginLoadingState());
    (await _authRepository.login(
      phoneNumber: _loginHelper.getPhoneNumber(_loginHelper.phoneController),
      password: _loginHelper.passwordController.text,
    ))
        .fold(
      (failure) => emit(LoginFailureState(failure)),
      (user) => emit(LoginSuccessState(user)),
    );
  }

  Future<void> forgetPassword() async {
    emit(LoginForgetPasswordLoadingState());
    (await _authRepository.forgetPassword(
      phoneNumber: _loginHelper.getPhoneNumber(
        _loginHelper.forgetPasswordPhoneController,
      ),
    ))
        .fold(
      (failure) => emit(LoginForgetPasswordFailureState(failure)),
      (message) => emit(LoginForgetPasswordSuccessState(message)),
    );
  }
}
