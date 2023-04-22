import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/category_service/category_service_impl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categoryService = CategoryServiceImpl(http.Client());

  void checkData() async {
    final x = await categoryService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    checkData();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Trang Chủ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "Cập nhật",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              "Y Tiên - Vân Mạc",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Tác giả",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Một miếng ngói xanh",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              "Chương 1: Vân Mạc  (1)",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "Đây có lẽ chính là",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
