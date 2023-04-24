import 'package:flutter/material.dart';

import '../models/story_book.dart';
import '../shared/styles/app_colors.dart';

class StoryCard extends StatelessWidget {
  final StoryBook storyBook;
  const StoryCard({
    super.key,
    required this.storyBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          ///
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                storyBook.poster ?? '',
              ),
              backgroundColor: AppColors.onPrimary,
              radius: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storyBook.title ?? '...',
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    storyBook.author ?? '...',
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    storyBook.status ?? '...',
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    storyBook.updatedDate ?? '...',
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
