import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/view/control_screen.dart';
import '../../auth/view/auth_method_screen.dart';
import '../../auth/view/forget_password_screen.dart';
import '../../auth/view/login_screen.dart';
import '../../auth/view/signup_screen.dart';
import '../../auth/view_model/login/login_view_model.dart';
import '../../auth/view_model/signup/signup_view_model.dart';
import '../../auth/view/on_boarding_screen.dart';
import '../../common/view/settings_screen.dart';
import '../../common/view_model/main_view_model/main_view_model.dart';
import '../../auth/view/splash_screen.dart';
import '../../store/view/add_product_screen.dart';
import '../../store/view/my_products_screen.dart';
import '../services/dependency_inj.dart';
import 'navigation_transitions.dart';
import 'routes.dart';
import 'platform_routing.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return platformPageRoute(const SplashScreen());

      /// auth routes
      case Routes.onBoardingScreen:
        return platformPageRoute(OnBoardingScreen());
      case Routes.authMethodScreen:
        return NavigationSlideTransition(const AuthMethodScreen());
      case Routes.loginScreen:
        initLoginVM();
        return platformPageRoute(
          BlocProvider(
            create: (_) => getItInstance<LoginViewModel>.call(),
            child: const LoginScreen(),
          ),
        );
      case Routes.forgetPasswordScreen:
        return platformPageRoute(
          BlocProvider.value(
            value: getItInstance<LoginViewModel>.call(),
            child: const ForgetPasswordScreen(),
          ),
        );
      case Routes.signupScreen:
        initSignupVM();
        return platformPageRoute(
          BlocProvider(
            create: (_) => getItInstance<SignupViewModel>.call(),
            child: const SignupScreen(),
          ),
        );

      /// common routes
      case Routes.controlScreen:
        initMainVM();
        return platformPageRoute(
          BlocProvider(
            create: (_) => getItInstance<MainViewModel>.call(),
            child: const ControlScreen(),
          ),
        );
      case Routes.settingsScreen:
        return platformPageRoute(const SettingsScreen());

      /// store routes
      case Routes.addProductScreen:
        return platformPageRoute(const AddProductScreen());
      case Routes.myProductsScreen:
        return platformPageRoute(const MyProductsScreen());

      /// default route
      default:
        return platformPageRoute(const Scaffold());
    }
  }
}
