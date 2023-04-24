import 'package:equatable/equatable.dart';

import '../../models/chapter.dart';

abstract class ChapterDetailByStoryState extends Equatable {
  const ChapterDetailByStoryState();

  @override
  List<Object> get props => [];
}

class ChapterDetailByStoryInitial extends ChapterDetailByStoryState {}

class ChapterDetailByStoryLoadInProgress extends ChapterDetailByStoryState {}

class ChapterDetailByStoryLoadFailure extends ChapterDetailByStoryState {}

class ChapterDetailByStoryLoadSuccess extends ChapterDetailByStoryState {
  final Chapter chapter;
  const ChapterDetailByStoryLoadSuccess(this.chapter);

  @override
  List<Object> get props => [chapter];
}
