import 'package:equatable/equatable.dart';

class CategoryBook extends Equatable {
  late final int _id;
  final String? name;

  int get id => _id;

  CategoryBook({required int id, this.name}) {
    _id = id;
  }

  factory CategoryBook.fromJson(Map<String, dynamic> json) {
    assert(json['id']);
    return CategoryBook(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [
        _id,
        name,
      ];
}
