import 'package:equatable/equatable.dart';

import '../../models/story_book.dart';

abstract class StoryDetailState extends Equatable {
  const StoryDetailState();

  @override
  List<Object?> get props => [];
}

class StoryDetailInitial extends StoryDetailState {}

class StoryDetailLoadInProgress extends StoryDetailState {}

class StoryDetailLoadFailure extends StoryDetailState {}

class StoryDetailLoadInSuccess extends StoryDetailState {
  final StoryBook storyBook;
  const StoryDetailLoadInSuccess(this.storyBook);
  @override
  List<Object?> get props => [storyBook];
}
