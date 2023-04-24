import 'package:bloc/bloc.dart';

import '../../services/story_service/story_service.dart';
import 'story_detail_event.dart';
import 'story_detail_state.dart';

class StoryDetailBloc extends Bloc<StoryDetailEvent, StoryDetailState> {
  final StoryService _storyService;
  StoryDetailBloc(this._storyService) : super(StoryDetailInitial()) {
    on<StoryDetailRequested>((event, emit) async {
      emit(StoryDetailLoadInProgress());
      try {
        final result = await _storyService.getStoryDetail(event.storyId);
        if (result != null) {
          emit(StoryDetailLoadInSuccess(result));
        } else {
          emit(StoryDetailLoadFailure());
        }
      } catch (e) {
        emit(StoryDetailLoadFailure());
      }
    });
  }
}
