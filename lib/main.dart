import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/config/app_config.dart';
import 'src/story_book_app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  await AppConfig().initialize();

  runApp(const StoryBookApp());
}
