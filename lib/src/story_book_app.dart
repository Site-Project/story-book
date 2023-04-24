import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:storybook/src/blocs/Story_detail_bloc/story_detail_bloc.dart';
import 'package:storybook/src/blocs/chapter_list_bloc/chapter_list_bloc.dart';

import 'blocs/category_bloc/category_book_bloc.dart';
import 'blocs/page_number_shower_cubit/page_number_shower_cubit.dart';
import 'blocs/story_by_category_list_bloc/story_by_category_list_bloc.dart';
import 'config/app_router.dart';
import 'services/category_service/category_service.dart';
import 'services/category_service/category_service_impl.dart';
import 'services/story_service/story_service.dart';
import 'services/story_service/story_service_impl.dart';
import 'shared/constants/app_constants.dart';
import 'shared/styles/theme.dart';

class StoryBookApp extends StatelessWidget {
  const StoryBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryService categoryService = CategoryServiceImpl(http.Client());
    final StoryService storyService = StoryServiceImpl(http.Client());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBookBloc(categoryService)),
        BlocProvider(
          create: (context) => StoryByCategoryListBloc(categoryService),
        ),
        BlocProvider(create: (context) => PageNumberShowerCubit()),
        BlocProvider(create: (context) => StoryDetailBloc(storyService)),
        BlocProvider(create: (context) => ChapterListBloc(storyService)),
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
