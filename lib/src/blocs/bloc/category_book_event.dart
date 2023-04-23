import 'package:equatable/equatable.dart';

abstract class CategoryBookEvent extends Equatable {
  const CategoryBookEvent();

  @override
  List<Object> get props => [];
}

class CategoryBookRequested extends CategoryBookEvent {}
