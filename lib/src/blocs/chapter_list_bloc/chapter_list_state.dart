import 'package:equatable/equatable.dart';

import '../../models/chapter.dart';

abstract class ChapterListState extends Equatable {
  const ChapterListState();

  @override
  List<Object> get props => [];
}

class ChapterListInitial extends ChapterListState {}

class ChapterListLoadInProgress extends ChapterListState {}

class ChapterListLoadSuccess extends ChapterListState {
  final List<Chapter> chapters;
  const ChapterListLoadSuccess(this.chapters);

  @override
  List<Object> get props => [chapters];
}

class ChapterListLoadFailure extends ChapterListState {}
