import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/resources/assets_manager.dart';
import '../../core/utils/storage_keys.dart';
import '../../core/widgets/status_bar.dart';
import '../../core/components/naqlah_logo.dart';
import '../../core/services/cache_factory.dart';
import '../../core/resources/values_manager.dart';
import '../../core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final String startScreen;

  @override
  void initState() {
    super.initState();
    Timer(
      Time.t1000,
      () {
        final bool isOnBoardingSeen =
            CacheFactory.get(StorageKeys.isOnBoardingSeen) ?? false;
        final bool isAuthed = CacheFactory.get(StorageKeys.isAuthed) ?? false;
        if (isOnBoardingSeen) {
          if (isAuthed) {
            startScreen = Routes.controlScreen;
          } else {
            startScreen = Routes.authMethodScreen;
          }
        } else {
          startScreen = Routes.onBoardingScreen;
        }
        Navigator.pushReplacementNamed(context, startScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(Image.asset(AppImages.authMethodBG).image, context);
    return const DarkStatusBar(
      child: Scaffold(
        body: Center(
          child: NaqlahLogo(),
        ),
      ),
    );
  }
}
