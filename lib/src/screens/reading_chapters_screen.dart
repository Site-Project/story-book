import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../blocs/chapter_detail_by_story_bloc/chapter_detail_by_story_bloc.dart';
import '../blocs/chapter_detail_by_story_bloc/chapter_detail_by_story_event.dart';
import '../blocs/chapter_detail_by_story_bloc/chapter_detail_by_story_state.dart';
import '../blocs/chapter_list_bloc/chapter_list_bloc.dart';
import '../blocs/chapter_list_bloc/chapter_list_state.dart';
import '../models/chapter.dart';
import '../services/chapter_service/chapter_service_imple.dart';
import '../widgets/loading_failure_content.dart';
import '../widgets/loading_indicator.dart';

class ReadingChaptersScreen extends StatefulWidget {
  const ReadingChaptersScreen({super.key});

  @override
  State<ReadingChaptersScreen> createState() => _ReadingChaptersScreenState();
}

class _ReadingChaptersScreenState extends State<ReadingChaptersScreen> {
  final PageController chapterPageController = PageController();
  final List<Chapter> allChapter = [];

  @override
  void initState() {
    ChapterListState state = context.read<ChapterListBloc>().state;
    if (state is ChapterListLoadSuccess) {
      allChapter.addAll(state.chapters.reversed);
    }
    super.initState();
  }

  @override
  void dispose() {
    chapterPageController.dispose();

    super.dispose();
  }

  void loadChapter() {}
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
            Navigator.pop(context);
          },
        ),
      ),
      body: PageView.builder(
          controller: chapterPageController,
          itemCount: allChapter.length,
          itemBuilder: (context, index) {
            return ChapterItem(chapterId: allChapter[index].id);
          }),
    );
  }
}

class ChapterItem extends StatefulWidget {
  final int chapterId;
  const ChapterItem({super.key, required this.chapterId});

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem>
    with AutomaticKeepAliveClientMixin {
  final chapterBloc = ChapterDetailByStoryBloc(
    ChapterServiceImpl(http.Client()),
  );
  @override
  Widget build(BuildContext context) {
    print('aaa');
    super.build(context);
    return BlocBuilder<ChapterDetailByStoryBloc, ChapterDetailByStoryState>(
      bloc: chapterBloc,
      builder: (context, state) {
        if (state is ChapterDetailByStoryInitial) {
          chapterBloc.add(ChapterDetailByStoryRequested(widget.chapterId));
        }
        if (state is ChapterDetailByStoryLoadInProgress) {
          return const LoadingIndicator();
        }
        if (state is ChapterDetailByStoryLoadFailure) {
          return LoadingFailureContent(
            onRetry: () {
              chapterBloc.add(ChapterDetailByStoryRequested(widget.chapterId));
            },
          );
        }
        if (state is ChapterDetailByStoryLoadSuccess) {
          return ListView(
            children: [
              Text(
                state.chapter.header ?? '...',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.green[700],
                    ),
                textAlign: TextAlign.center,
              ),
              ...(state.chapter.body ?? [])
                  .map(
                    (e) => Html(
                      data: e,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  )
                  .toList(),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
