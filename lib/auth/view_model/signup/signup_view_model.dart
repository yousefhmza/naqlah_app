import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../core/network/error_handler.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/utils/alerts.dart';
import '../../helpers/signup_helper.dart';
import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';
import 'signup_states.dart';

class SignupViewModel extends Cubit<SignupStates> {
  SignupViewModel() : super(SignupInitialState());

  final SignupHelper _signupHelper = SignupHelper.instance;
  final AuthRepository _authRepository = AuthRepository.instance;

  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  /// first step functions
  Future<void> sendOTP() async {
    if (_signupHelper.phoneFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      emit(SignupLoadingState());
      final String _appSignature = await SmsAutoFill().getAppSignature;
      (await _authRepository.sendOTP(
        _signupHelper.getPhoneNumber(),
        _appSignature,
      ))
          .fold(
        (failure) => emit(SignupFailureState(failure)),
        (otp) {
          _signupHelper.setOTP(otp);
          _toNextPage();
        },
      );
    }
  }

  /// second step functions
  void toUserTypePage(String? code) async {
    emit(SignupLoadingState());
    await Future.delayed(Time.t1000, () {
      if (code == _signupHelper.otp) {
        _toNextPage();
      } else {
        if (code?.length == 6) {
          emit(SignupFailureState(ErrorType.wrongOTP.getFailure()));
        }
      }
    });
  }

  /// third step functions
  void toRegisterPage() async {
    if (_signupHelper.selectedUserType != null) {
      // just to give the the user the illusion of loading but using future isn't necessary here
      emit(SignupLoadingState());
      await Future.delayed(
        Time.t1000,
        () => _toNextPage(),
      );
    } else {
      Alerts.showToast(AppStrings.selectUserAlert, ToastGravity.TOP);
    }
  }

  void setSelectedUserType(UserType userType) {
    _signupHelper.setSelectedUserType(userType);
    emit(SignupSelectedUserTypeState());
  }

  /// fourth step functions
  Future<void> register() async {
    if (_signupHelper.registerFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      emit(SignupLoadingState());
      (await _authRepository.register(
        name: _signupHelper.usernameController.text,
        phoneNumber: _signupHelper.getPhoneNumber(),
        password: _signupHelper.passwordController.text,
        userType: _signupHelper.selectedUserType!.name,
        storeName: _signupHelper.storeNameController.text,
        storeAddress: _signupHelper.addressController.text,
        storeCityId: _signupHelper.selectedCity!.id,
        storeGovernorateId: _signupHelper.selectedGovernorate!.id,
      ))
          .fold(
        (failure) => emit(SignupFailureState(failure)),
        (user) => emit(SignupSuccessState(user)),
      );
    }
  }

  /// core functions
  void _toNextPage() {
    _currentPageIndex++;
    _signupHelper.pageController.nextPage(
      duration: Time.t300,
      curve: Curves.fastOutSlowIn,
    );
    emit(SignupSetCurrentPageIndexState());
  }
}
