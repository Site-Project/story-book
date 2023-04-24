import 'package:bloc/bloc.dart';

import '../../services/chapter_service/chapter_service.dart';
import 'chapter_detail_by_story_event.dart';
import 'chapter_detail_by_story_state.dart';

class ChapterDetailByStoryBloc
    extends Bloc<ChapterDetailByStoryEvent, ChapterDetailByStoryState> {
  final ChapterService _chapterService;

  ChapterDetailByStoryBloc(this._chapterService)
      : super(ChapterDetailByStoryInitial()) {
    on<ChapterDetailByStoryRequested>((event, emit) async {
      emit(ChapterDetailByStoryLoadInProgress());
      try {
        final result = await _chapterService.getChapterDetail(event.chappterId);
        if (result != null) {
          emit(ChapterDetailByStoryLoadSuccess(result));
        } else {
          emit(ChapterDetailByStoryLoadFailure());
        }
      } catch (e) {
        emit(ChapterDetailByStoryLoadFailure());
      }
    });
  }
}
