import 'package:equatable/equatable.dart';

abstract class ChapterDetailByStoryEvent extends Equatable {
  const ChapterDetailByStoryEvent();

  @override
  List<Object> get props => [];
}

class ChapterDetailByStoryRequested extends ChapterDetailByStoryEvent {
  final int chappterId;

  const ChapterDetailByStoryRequested(this.chappterId);

  @override
  List<Object> get props => [chappterId];
}
