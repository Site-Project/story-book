import 'package:flutter/cupertino.dart';

import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/splash_screen.dart';
import '../shared/constants/app_constants.dart';

class AppRouter {
  CupertinoPageRoute pageRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      switch (settings.name) {
        case RouteNames.initial:
          return const SplashScreen();
        case RouteNames.home:
          return HomeScreen();
        default:
          return const NotFoundScreen();
      }
    });
  }
}
