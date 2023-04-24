import 'package:equatable/equatable.dart';
import 'package:storybook/src/models/story_book.dart';

abstract class StoryByCategoryListState extends Equatable {
  const StoryByCategoryListState();

  @override
  List<Object?> get props => [];
}

class StoryByCategoryListInitial extends StoryByCategoryListState {}

class StoryByCategoryListLoadInProgress extends StoryByCategoryListState {}

class StoryByCategoryListSuccess extends StoryByCategoryListState {
  final List<StoryBook> stories;
  final int currentPage;
  const StoryByCategoryListSuccess({
    required this.stories,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [
        stories,
        currentPage,
      ];
}

class StoryByCategoryListFailure extends StoryByCategoryListState {}
