import 'package:bloc/bloc.dart';

import '../../models/story_book.dart';
import '../../services/category_service/category_service.dart';
import 'story_by_category_list_event.dart';
import 'story_by_category_list_state.dart';

class StoryByCategoryListBloc
    extends Bloc<StoryByCategoryListEvent, StoryByCategoryListState> {
  final CategoryService _categoryService;
  List<StoryBook> _stories = const [];
  int _currentPage = 0;
  StoryByCategoryListBloc(this._categoryService)
      : super(StoryByCategoryListInitial()) {
    on<StoryByCategoryListRequested>((event, emit) async {
      emit(StoryByCategoryListLoadInProgress());

      try {
        final results = await _categoryService.getStoriesByCategory(
          categoryId: event.id,
          page: event.page ?? _currentPage,
        );

        if (event.page != null) {
          _stories = results ?? const [];
          _currentPage = event.page!;
        } else {
          _stories = List.of(_stories)..addAll(results ?? const []);
          _currentPage++;
        }

        emit(StoryByCategoryListSuccess(
          stories: _stories,
          currentPage: _currentPage,
        ));
      } catch (e) {
        emit(StoryByCategoryListFailure());
      }
    });
  }
}
