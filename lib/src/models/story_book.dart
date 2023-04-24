import 'package:equatable/equatable.dart';
import 'package:storybook/src/models/category_book.dart';
import 'package:storybook/src/shared/helpers/story_book.helper.dart';
import 'package:storybook/src/shared/helpers/string_helper.dart';

class StoryBook extends Equatable {
  late final int _id;
  final String? title;
  final String? author;
  final String? poster;
  final String? status;
  final String? updatedDate;
  final List<String>? description;
  final List<String>? categories;
  final double rateCount;

  int get id => _id;

  String get updateDateTime {
    final strReplace = updatedDate?.replaceAll(RegExp(r'T'), ' ');
    final result = strReplace?.split('.').first;
    return result ?? '';
  }

  StoryBook({
    required int id,
    this.title,
    this.author,
    this.poster,
    this.status,
    this.updatedDate,
    this.categories,
    this.description,
    this.rateCount = 0.0,
  }) {
    _id = id;
  }

  factory StoryBook.fromJson(Map<String, dynamic> json) {
    assert(json['id'] != null);
    return StoryBook(
      id: json['id'],
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      poster: json['poster'] ?? '',
      status: json['status'] ?? '',
      updatedDate: json['updatedDate'] ?? '',
      description: StoryBookHelper.buildDescription(json['description']),
      categories: StoryBookHelper.buildCategories(json['categories'] ?? []),
      rateCount: json['rateCount'] ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [
        _id,
        poster,
        title,
        author,
        status,
        updatedDate,
        categories,
        rateCount,
        description,
      ];
}
