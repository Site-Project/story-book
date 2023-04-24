import 'package:flutter/material.dart';

import '../shared/constants/app_constants.dart' as constants;
import '../shared/helpers/iterable_helper.dart';
import '../shared/styles/app_colors.dart';

class StoryDetailScreen extends StatelessWidget {
  const StoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 25,
          color: Colors.black,
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.onPrimary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/avatar_1.png',
                  ),
                  backgroundColor: AppColors.onPrimary,
                  radius: 60,
                ),
                const SizedBox(height: 10),
                Text(
                  'Trúc mã và kẻ từ trên trời rơi xuống',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          StoryInfomationCard(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                constants.StoryDetail.read,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StoryInfomationCard extends StatelessWidget {
  // final StoryBook storyBook;

  const StoryInfomationCard({
    super.key,
    // required this.storyBook,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StoryInformationItem(
            title: constants.StoryDetail.author,
            information: 'Tiểu Haj',
            enableClick: true,
          ),
          StoryInformationItem(
            title: constants.StoryDetail.type,
            information: 'Tiểu Haj',
            enableClick: true,
          ),
          StoryInformationItem(
            title: constants.StoryDetail.status,
            information: 'Tiểu Haj',
          ),
          StoryInformationItem(
            title: constants.StoryDetail.rate,
            information: 'Tiểu Haj',
          ),
        ],
      ),
    );
  }
}

class StoryInformationItem extends StatelessWidget {
  final String title;
  final String information;
  final List<String> informations;
  final bool enableClick;
  const StoryInformationItem({
    super.key,
    required this.title,
    this.information = '...',
    this.informations = const [],
    this.enableClick = false,
  });

  String buildInformations(List<String> infors) {
    String result = '';
    for (var i = 0; i < infors.length; i++) {
      if (i == 0) {
        result += infors[i];
      } else {
        result += ', ${infors[i]}';
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium,
        ),
        IterableHelper.isNullOrEmpty(informations)
            ? Text(
                information,
                style: theme.textTheme.titleMedium?.copyWith(
                    color: enableClick ? AppColors.primary : Colors.black,
                    fontWeight:
                        enableClick ? FontWeight.bold : FontWeight.w500),
              )
            : Text(
                buildInformations(informations),
                style: theme.textTheme.titleMedium?.copyWith(
                    color: enableClick ? AppColors.primary : Colors.black,
                    fontWeight:
                        enableClick ? FontWeight.bold : FontWeight.w500),
              ),
      ],
    );
  }
}
