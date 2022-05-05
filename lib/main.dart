import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/view_model/products_view_model/products_view_model.dart';
import 'core/services/bloc_observer.dart';
import 'core/utils/globals.dart';
import 'core/services/network/dio_factory.dart';
import 'core/services/cache_factory.dart';
import 'core/resources/theme_manager.dart';
import 'core/routing/route_generator.dart';
import 'core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheFactory.init();
  await DioFactory.init();
  await getAllGovernorates();
  await getAllCities();

  BlocOverrides.runZoned(
    () {
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => ProductsViewModel(),
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393.0, 760.0),
      splitScreenMode: false,
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Naqlah",
        theme: ThemeManager.lightTheme,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return widget!;
        },
      ),
    );
  }
}
