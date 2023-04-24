import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storybook/src/blocs/chapter_list_bloc/chapter_list_bloc.dart';
import 'package:storybook/src/blocs/chapter_list_bloc/chapter_list_event.dart';
import 'package:storybook/src/blocs/chapter_list_bloc/chapter_list_state.dart';

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
  late final StreamSubscription _chappterListener;
  @override
  void initState() {
    context.read<StoryDetailBloc>().add(StoryDetailRequested(widget.storyId));
    _chappterListener = context.read<StoryDetailBloc>().stream.listen((state) {
      if (state is StoryDetailLoadInSuccess) {
        context.read<ChapterListBloc>().add(
              ChapterListRequested(state.storyBook.slug),
            );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _chappterListener.cancel();
    super.dispose();
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
        builder: (context, storyDetailState) {
          return Stack(
            children: [
              storyDetailState is StoryDetailLoadInSuccess
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
                                    storyDetailState.storyBook.poster ?? '',
                                  ),
                                  backgroundColor: AppColors.onPrimary,
                                  radius: 60,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  storyDetailState.storyBook.title ?? '...',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          StoryInfomationCard(
                              storyBook: storyDetailState.storyBook),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  constants.RouteNames.readingChapter,
                                );
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
                              children:
                                  (storyDetailState.storyBook.description ?? [])
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
                          const SizedBox(height: 10),
                          BlocBuilder<ChapterListBloc, ChapterListState>(
                            builder: (context, chapterListState) {
                              return Container(
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
                                  children: [
                                    Text(
                                      constants.StoryDetail.newChapters,
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    chapterListState
                                            is ChapterListLoadInProgress
                                        ? const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: LoadingIndicator(),
                                          )
                                        : const SizedBox.shrink(),
                                    chapterListState is ChapterListLoadFailure
                                        ? LoadingFailureContent(onRetry: () {
                                            context.read<ChapterListBloc>().add(
                                                  ChapterListRequested(
                                                    storyDetailState
                                                        .storyBook.slug,
                                                  ),
                                                );
                                          })
                                        : const SizedBox.shrink(),
                                    chapterListState is ChapterListLoadSuccess
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                              5,
                                              (index) {
                                                final chapter = chapterListState
                                                    .chapters[index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Text(
                                                    chapter.header ?? '...',
                                                    style: theme
                                                        .textTheme.titleMedium,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              storyDetailState is StoryDetailLoadInProgress
                  ? const LoadingIndicator()
                  : const SizedBox.shrink(),
              storyDetailState is StoryDetailLoadFailure
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
