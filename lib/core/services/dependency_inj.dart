import 'package:get_it/get_it.dart';

import '../../auth/view_model/login/login_view_model.dart';
import '../../auth/view_model/signup/signup_view_model.dart';
import '../../common/view_model/main_view_model/main_view_model.dart';

final GetIt getItInstance = GetIt.instance;

void initSignupVM() {
  getItInstance.registerLazySingleton<SignupViewModel>(() => SignupViewModel());
}

void removeSignupVM() {
  getItInstance.unregister<SignupViewModel>(
    instance: getItInstance<SignupViewModel>(),
  );
}

void initLoginVM() {
  getItInstance.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
}

void removeLoginVM() {
  getItInstance.unregister<LoginViewModel>(
    instance: getItInstance<LoginViewModel>(),
  );
}

void initMainVM() {
  getItInstance.registerLazySingleton<MainViewModel>(() => MainViewModel());
}

void removeMainVM() {
  getItInstance.unregister<MainViewModel>(
    instance: getItInstance<MainViewModel>(),
  );
}
