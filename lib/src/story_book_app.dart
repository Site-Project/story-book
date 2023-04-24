import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/category_bloc/category_book_bloc.dart';
import 'blocs/story_by_category_list_bloc/story_by_category_list_bloc.dart';
import 'config/app_router.dart';
import 'services/category_service/category_service.dart';
import 'services/category_service/category_service_impl.dart';
import 'shared/constants/app_constants.dart';
import 'shared/styles/theme.dart';

class StoryBookApp extends StatelessWidget {
  const StoryBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryService categoryService = CategoryServiceImpl(http.Client());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBookBloc(categoryService)),
        BlocProvider(
          create: (context) => StoryByCategoryListBloc(categoryService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: RouteNames.initial,
        onGenerateRoute: AppRouter().pageRoute,
      ),
    );
  }
}
