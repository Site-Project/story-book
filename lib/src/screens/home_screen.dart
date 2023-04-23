import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/retry_button.dart';

import '../blocs/bloc/category_book_bloc.dart';
import '../blocs/bloc/category_book_event.dart';
import '../blocs/bloc/category_book_state.dart';
import '../models/category_book.dart';
import '../shared/constants/app_constants.dart' as constants;
import '../shared/helpers/iterable_helper.dart';
import '../shared/styles/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<CategoryBookBloc>().add(CategoryBookRequested());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<CategoryBookBloc>().add(CategoryBookRequested());
              },
              child: BlocBuilder<CategoryBookBloc, CategoryBookState>(
                builder: (context, state) {
                  List<CategoryBook> categories = [];
                  int hafdOfLength = 0;
                  if (state is CategoryBookLoadSuccess) {
                    categories = state.list;
                    hafdOfLength = (categories.length / 2).ceil();
                  }
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: List.generate(hafdOfLength, (index) {
                            int leftItem = (2 * index);
                            int rightItem = (2 * index) + 1;
                            return IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    leftItem < categories.length
                                        ? _CategoryItem(
                                            data: categories[leftItem])
                                        : const SizedBox.shrink(),
                                    SizedBox(
                                        width: rightItem < categories.length
                                            ? 15
                                            : 0),
                                    rightItem < categories.length
                                        ? _CategoryItem(
                                            data: categories[rightItem])
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      state is CategoryBookLoadFailure &&
                              IterableHelper.isNullOrEmpty(categories)
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      constants.ErrorMessage.getListFailure,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    ReTryButtom(
                                      title: constants.Global.retry,
                                      onRetry: () {
                                        context
                                            .read<CategoryBookBloc>()
                                            .add(CategoryBookRequested());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      state is CategoryBookLoadInProgress
                          ? Center(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const CircularProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryBook data;
  const _CategoryItem({
    Key? key,
    required this.data,
  }) : super(key: key);

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
