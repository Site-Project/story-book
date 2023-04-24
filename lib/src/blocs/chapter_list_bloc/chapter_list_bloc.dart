import 'package:bloc/bloc.dart';

import '../../services/story_service/story_service.dart';
import 'chapter_list_event.dart';
import 'chapter_list_state.dart';

class ChapterListBloc extends Bloc<ChapterListEvent, ChapterListState> {
  final StoryService _storyService;
  ChapterListBloc(this._storyService) : super(ChapterListInitial()) {
    on<ChapterListRequested>((event, emit) async {
      emit(ChapterListLoadInProgress());
      try {
        final results = await _storyService.getChapterByStory(event.storySlug);
        if (results != null) {
          emit(ChapterListLoadSuccess(results));
        } else {
          emit(ChapterListLoadFailure());
        }
      } catch (e) {
        emit(ChapterListLoadFailure());
      }
    });
  }
}
