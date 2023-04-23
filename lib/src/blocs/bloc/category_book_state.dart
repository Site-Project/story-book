import 'package:equatable/equatable.dart';

import '../../models/category_book.dart';

abstract class CategoryBookState extends Equatable {
  const CategoryBookState();

  @override
  List<Object> get props => [];
}

class CategoryBookInitial extends CategoryBookState {}

class CategoryBookLoadInProgress extends CategoryBookState {}

class CategoryBookLoadFailure extends CategoryBookState {}

class CategoryBookLoadSuccess extends CategoryBookState {
  final List<CategoryBook> list;
  const CategoryBookLoadSuccess(this.list);

  @override
  List<Object> get props => [list];
}
