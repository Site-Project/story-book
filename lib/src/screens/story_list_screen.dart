import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/story_by_category_list_bloc/story_by_category_list_bloc.dart';
import '../blocs/story_by_category_list_bloc/story_by_category_list_event.dart';
import '../blocs/story_by_category_list_bloc/story_by_category_list_state.dart';
import '../models/category_book.dart';
import '../models/story_book.dart';
import '../shared/constants/app_constants.dart' as constants;
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
  int _currentPage = 0;
  List<StoryBook> _stories = [];
  final ScrollController _storyListController = ScrollController();

  @override
  void initState() {
    context.read<StoryByCategoryListBloc>().add(StoryByCategoryListRequested(
          id: widget.data.id,
          page: _currentPage,
        ));

    _storyListController.addListener(() {
      if (_storyListController.position.pixels ==
          _storyListController.position.maxScrollExtent) {
        int nextPage = _currentPage + 1;
        context
            .read<StoryByCategoryListBloc>()
            .add(StoryByCategoryListRequested(
              id: widget.data.id,
              page: nextPage,
            ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _storyListController.dispose();
    super.dispose();
  }

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
        centerTitle: false,
        title: Text(widget.data.name ?? ''),
        titleTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(color: AppColors.primary),
      ),
      body: BlocConsumer<StoryByCategoryListBloc, StoryByCategoryListState>(
        listener: (context, state) {
          if (state is StoryByCategoryListFailure && _stories.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  constants.ErrorMessage.getListFailure,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                backgroundColor: AppColors.onPrimary,
                margin: const EdgeInsets.all(10),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is StoryByCategoryListSuccess) {
            _currentPage = state.currentPage;
            _stories = state.stories;
          }
          return Column(
            children: [
              Flexible(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<StoryByCategoryListBloc>()
                        .add(StoryByCategoryListRequested(
                          id: widget.data.id,
                          page: 0,
                        ));
                  },
                  child: ListView.builder(
                    controller: _storyListController,
                    itemCount: _stories.length,
                    itemBuilder: (context, index) {
                      if (index == _stories.length - 1) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: StoryCard(storyBook: _stories[index]),
                        );
                      }
                      return StoryCard(storyBook: _stories[index]);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "${_currentPage + 1}",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
