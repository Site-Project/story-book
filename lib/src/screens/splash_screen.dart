import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shared/constants/app_assets.dart';
import '../shared/constants/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      Navigator.pushReplacementNamed(context, RouteNames.home);
    });
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AppAssets.appLogo,
          height: 150,
        ),
      ),
    );
  }
}
