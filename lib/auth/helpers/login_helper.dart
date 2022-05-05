import 'package:flutter/material.dart';

import '../../core/services/cache_factory.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/alerts.dart';
import '../../core/utils/storage_keys.dart';

class LoginHelper {
  LoginHelper._privateConstructor();

  static final LoginHelper instance = LoginHelper._privateConstructor();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController forgetPasswordPhoneController;

  void initControllers() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    forgetPasswordPhoneController = TextEditingController();
  }

  void disposeControllers() {
    phoneController.dispose();
    passwordController.dispose();
    forgetPasswordPhoneController.dispose();
  }

  String getPhoneNumber(TextEditingController controller) {
    final String _enteredPhoneNumber = controller.text;
    final String _phoneNumber =
        _enteredPhoneNumber.substring(_enteredPhoneNumber.length - 10);
    final String _completePhoneNumber = "+20" + _phoneNumber;
    return _completePhoneNumber;
  }

  Future<void> afterAuth(
      BuildContext context, bool isSignup, String uid) async {
    await CacheFactory.saveSecuredData(StorageKeys.uid, uid);
    await CacheFactory.save(StorageKeys.isAuthed, true);
    Alerts.showToast(
      isSignup ? AppStrings.signupSuccess : AppStrings.loginSuccess,
    );
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.controlScreen,
      (route) => false,
    );
  }
}
