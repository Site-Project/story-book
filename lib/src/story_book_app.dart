import 'package:flutter/material.dart';

import 'config/app_router.dart';
import 'shared/constants/app_constants.dart';

class StoryBookApp extends StatelessWidget {
  const StoryBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.initial,
      onGenerateRoute: AppRouter().pageRoute,
    );
  }
}
