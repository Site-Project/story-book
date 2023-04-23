import 'package:flutter/material.dart';

import '../models/category_book.dart';
import '../shared/constants/app_constants.dart' as constants;
import '../shared/styles/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoryBook(id: 0, name: 'Truyện Full'),
      CategoryBook(id: 1, name: 'Truyện Full chọn lọc'),
      CategoryBook(id: 0, name: 'Truyện Full'),
      CategoryBook(id: 0, name: 'Truyện Full'),
      CategoryBook(id: 0, name: 'Truyện Full'),
      CategoryBook(id: 1, name: 'Truyện Full chọn lọc'),
      CategoryBook(id: 0, name: 'Truyện Full'),
      CategoryBook(id: 0, name: 'Truyện Full'),
      CategoryBook(id: 0, name: 'Truyện Full'),
    ];
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          constants.Home.title,
          style: theme.textTheme.displayMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
        leadingWidth: 0.0,
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary,
                  width: 4,
                ),
              ),
            ),
            child: Text(
              constants.Home.category,
              style: theme.textTheme.displaySmall?.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(children: [
                ...List.generate((categories.length / 2).ceil(), (index) {
                  int leftItem = (2 * index);
                  int rightItem = (2 * index) + 1;
                  return IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          leftItem < categories.length
                              ? CategoryItem(data: categories[leftItem])
                              : const SizedBox.shrink(),
                          SizedBox(
                              width: rightItem < categories.length ? 15 : 0),
                          rightItem < categories.length
                              ? CategoryItem(data: categories[rightItem])
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                }),
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryBook data;
  const CategoryItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final String title = data.name ?? '';
    return Flexible(
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: AppColors.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
