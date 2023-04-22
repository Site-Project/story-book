import 'package:flutter/cupertino.dart';

import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../shared/constants/app_constants.dart';

class AppRouter {
  CupertinoPageRoute pageRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      switch (settings.name) {
        case RouteNames.home:
          return const HomeScreen();
        default:
          return const NotFoundScreen();
      }
    });
  }
}
