import 'package:flutter/cupertino.dart';

import '../models/category_book.dart';
import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/reading_chapters_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/story_detail.dart';
import '../screens/story_list_screen.dart';
import '../shared/constants/app_constants.dart';

class AppRouter {
  CupertinoPageRoute pageRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      switch (settings.name) {
        case RouteNames.initial:
          return const SplashScreen();
        case RouteNames.home:
          return const HomeScreen();
        case RouteNames.storyList:
          if (settings.arguments is! CategoryBook) {
            return const NotFoundScreen();
          }
          final data = settings.arguments as CategoryBook;
          return StoryListScreen(data: data);
        case RouteNames.storyDetail:
          if (settings.arguments is! int) {
            return const NotFoundScreen();
          }
          final id = settings.arguments as int;
          return StoryDetailScreen(storyId: id);
        case RouteNames.readingChapter:
          return const ReadingChaptersScreen();
        default:
          return const NotFoundScreen();
      }
    });
  }
}
