import 'package:equatable/equatable.dart';

abstract class StoryDetailEvent extends Equatable {
  const StoryDetailEvent();

  @override
  List<Object> get props => [];
}

class StoryDetailRequested extends StoryDetailEvent {
  final int storyId;
  const StoryDetailRequested(this.storyId);

  @override
  List<Object> get props => [storyId];
}
