import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cubit/page_number_shower_cubit.dart';
import '../blocs/story_by_category_list_bloc/story_by_category_list_bloc.dart';
import '../blocs/story_by_category_list_bloc/story_by_category_list_event.dart';
import '../blocs/story_by_category_list_bloc/story_by_category_list_state.dart';
import '../models/category_book.dart';
import '../models/story_book.dart';
import '../shared/constants/app_constants.dart' as constants;
import '../shared/helpers/string_helper.dart';
import '../shared/styles/app_colors.dart';
import '../widgets/loading_failure_content.dart';
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
      if (_storyListController.position.userScrollDirection ==
          ScrollDirection.forward) {
        context.read<PageNumberShowerCubit>().showPageNumber();
      } else {
        context.read<PageNumberShowerCubit>().hidePageNumber();
      }
    });
    super.initState();
  }

  void _movePage(BuildContext context, int categoryId) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: MovePageForm(categoriId: widget.data.id),
          );
        });
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
          if (state is StoryByCategoryListFailure && _stories.isEmpty) {
            return LoadingFailureContent(
              onRetry: () {
                context.read<StoryByCategoryListBloc>().add(
                      StoryByCategoryListRequested(
                        id: widget.data.id,
                      ),
                    );
              },
            );
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
      floatingActionButton: BlocBuilder<PageNumberShowerCubit, bool>(
          builder: (context, isShowPageNumber) {
        if (isShowPageNumber) {
          return BlocBuilder<StoryByCategoryListBloc, StoryByCategoryListState>(
            builder: (context, state) {
              int currentPage = _currentPage;

              /// Update current number of page
              if (state is StoryByCategoryListSuccess) {
                currentPage = state.currentPage;
              }
              return FloatingActionButton(
                onPressed: () {
                  _movePage(context, widget.data.id);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "${currentPage + 1}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}

class MovePageForm extends StatefulWidget {
  final int categoriId;
  const MovePageForm({Key? key, required this.categoriId}) : super(key: key);

  @override
  State<MovePageForm> createState() => _MovePageFormState();
}

class _MovePageFormState extends State<MovePageForm> {
  final _pageNumberController = TextEditingController();
  bool canSubmit = false;

  void _checkSubmit(String? str) {
    if (StringHelper.isNotNullOrEmpty(str)) {
      if (!canSubmit) {
        setState(() {
          canSubmit = true;
        });
      }
    } else {
      setState(() {
        canSubmit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            constants.Global.movePageTitle,
            style: theme.textTheme.displaySmall,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              autofocus: true,
              controller: _pageNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: constants.Global.inputPage,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 2.5,
                )),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  width: 2.5,
                )),
              ),
              onChanged: _checkSubmit,
            ),
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: Text(
                  constants.Global.cancel,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (canSubmit) {
                    int? page = int.tryParse(_pageNumberController.text);
                    if (page != null) {
                      context
                          .read<StoryByCategoryListBloc>()
                          .add(StoryByCategoryListRequested(
                            id: widget.categoriId,
                            page: --page,
                          ));
                      Navigator.pop(context);
                    }
                  }
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: Text(
                  constants.Global.movePage,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: canSubmit ? AppColors.primary : Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
