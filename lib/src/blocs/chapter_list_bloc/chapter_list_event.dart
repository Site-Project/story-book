import 'package:equatable/equatable.dart';

abstract class ChapterListEvent extends Equatable {
  const ChapterListEvent();

  @override
  List<Object> get props => [];
}

class ChapterListRequested extends ChapterListEvent {
  final String storySlug;

  const ChapterListRequested(this.storySlug);

  @override
  List<Object> get props => [storySlug];
}
