import 'package:flutter/material.dart';

import '../models/category_book.dart';
import '../shared/styles/app_colors.dart';
import '../widgets/story_card.dart';

class StoryListScreen extends StatefulWidget {
  final CategoryBook data;
  const StoryListScreen({
    super.key,
    required this.data,
  });

  @override
  State<StoryListScreen> createState() => _StoryListScreenState();
}

class _StoryListScreenState extends State<StoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 25,
          color: Colors.black,
          splashRadius: 20,
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text(widget.data.name ?? ''),
        titleTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(color: AppColors.primary),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return StoryCard();
        },
      ),
    );
  }
}
