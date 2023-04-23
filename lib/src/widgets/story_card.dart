import 'package:flutter/material.dart';

import '../shared/styles/app_colors.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/avatar_1.png",
            ),
            radius: 40,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vạn Cổ Ma Tôn',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                'Lâm Nhất',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '510 chương - Đang ra',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '17:20:33 (1 Tuần trước)',
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ],
      ),
    );
    ;
  }
}
