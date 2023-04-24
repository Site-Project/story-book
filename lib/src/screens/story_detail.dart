import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/Story_detail_bloc/story_detail_bloc.dart';
import '../blocs/Story_detail_bloc/story_detail_event.dart';
import '../blocs/Story_detail_bloc/story_detail_state.dart';
import '../models/story_book.dart';
import '../shared/constants/app_constants.dart' as constants;
import '../shared/helpers/iterable_helper.dart';
import '../shared/styles/app_colors.dart';
import '../widgets/loading_failure_content.dart';
import '../widgets/loading_indicator.dart';

class StoryDetailScreen extends StatefulWidget {
  final int storyId;
  const StoryDetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  @override
  void initState() {
    context.read<StoryDetailBloc>().add(StoryDetailRequested(widget.storyId));
    super.initState();
  }

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
      body: BlocBuilder<StoryDetailBloc, StoryDetailState>(
        builder: (context, state) {
          return Stack(
            children: [
              state is StoryDetailLoadInSuccess
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<StoryDetailBloc>()
                            .add(StoryDetailRequested(widget.storyId));
                      },
                      child: ListView(
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
                                  backgroundImage: NetworkImage(
                                    state.storyBook.poster ?? '',
                                  ),
                                  backgroundColor: AppColors.onPrimary,
                                  radius: 60,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.storyBook.title ?? '...',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          StoryInfomationCard(storyBook: state.storyBook),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                ///
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                          ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (state.storyBook.description ?? [])
                                  .map(
                                    (e) => Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              state is StoryDetailLoadInProgress
                  ? const LoadingIndicator()
                  : const SizedBox.shrink(),
              state is StoryDetailLoadFailure
                  ? LoadingFailureContent(onRetry: () {
                      context
                          .read<StoryDetailBloc>()
                          .add(StoryDetailRequested(widget.storyId));
                    })
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}

class StoryInfomationCard extends StatelessWidget {
  final StoryBook storyBook;

  const StoryInfomationCard({
    super.key,
    required this.storyBook,
  });

  @override
  Widget build(BuildContext context) {
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
            information: storyBook.author ?? '...',
            enableClick: true,
          ),
          StoryInformationItem(
            title: constants.StoryDetail.type,
            informations: storyBook.categories ?? [],
            enableClick: true,
          ),
          StoryInformationItem(
            title: constants.StoryDetail.status,
            information: storyBook.status ?? '...',
          ),
          StoryInformationItem(
            title: constants.StoryDetail.rate,
            information:
                '${storyBook.rateCount} ${constants.StoryDetail.trailingRateText}',
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium,
        ),
        Expanded(
          child: IterableHelper.isNullOrEmpty(informations)
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
        ),
      ],
    );
  }
}
