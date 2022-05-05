import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/models/user_model.dart';
import '../../auth/repositories/auth_repository.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/spaces.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/utils/alerts.dart';
import '../../customer/view/customer_home_screen.dart';
import '../../core/components/retry_component.dart';
import '../../core/widgets/platform_widgets/loading_spinner.dart';
import '../../core/widgets/status_bar.dart';
import '../../core/network/error_handler.dart';
import '../../core/resources/values_manager.dart';
import '../../store/view/store_home_screen.dart';
import '../view_model/main_view_model/main_states.dart';
import '../view_model/main_view_model/main_view_model.dart';

// This widget just controls which app section will start based on the user type
class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  late MainViewModel _mainVM;

  @override
  void initState() {
    _mainVM = BlocProvider.of<MainViewModel>(context);
    _mainVM.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: BlocConsumer<MainViewModel, MainStates>(
        listener: (context, state) {
          if (state is MainGetCurrentUserFailureState &&
              state.failure.statusCode == ResponseCode.unAuthorized) {
            Alerts.showAppDialog(
              context,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(
                    AppStrings.sessionExpired,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.medium,
                  ),
                  VerticalSpace(deviceHeight * 0.02),
                  const LoadingSpinner(),
                ],
              ),
            );
            Timer(
              Time.t2000,
              () => AuthRepository.instance.logout(context),
            );
          }
        },
        builder: (context, state) {
          if (state is MainGetCurrentUserSuccessState) {
            return state.user.userType == UserType.customer
                ? const CustomerHomeScreen()
                : StoreHomeScreen();
          } else if (state is MainGetCurrentUserFailureState) {
            return state.failure.statusCode == ResponseCode.unAuthorized
                ? const Scaffold()
                : Scaffold(
                    body: Center(
                      child: RetryComponent(
                          onRetry: () => _mainVM.getCurrentUser()),
                    ),
                  );
          } else {
            return const Scaffold(
              body: Center(
                child: LoadingSpinner(),
              ),
            );
          }
        },
      ),
    );
  }
}
