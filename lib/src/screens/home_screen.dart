import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
