import 'package:equatable/equatable.dart';

abstract class StoryByCategoryListEvent extends Equatable {
  const StoryByCategoryListEvent();

  @override
  List<Object?> get props => [];
}

class StoryByCategoryListRequested extends StoryByCategoryListEvent {
  final int id;
  final int? page;
  const StoryByCategoryListRequested({required this.id, this.page});

  @override
  List<Object?> get props => [
        id,
        page,
      ];
}
