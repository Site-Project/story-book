import 'package:equatable/equatable.dart';

import '../shared/helpers/story_book.helper.dart';

class StoryBook extends Equatable {
  final int id;
  final String? title;
  final String? author;
  final String? poster;
  final String? status;
  final String? updatedDate;
  final List<String>? description;
  final List<String>? categories;
  final num rateCount;

  String get updateDateTime {
    final strReplace = updatedDate?.replaceAll(RegExp(r'T'), ' ');
    final result = strReplace?.split('.').first;
    return result ?? '';
  }

  StoryBook({
    required this.id,
    this.title,
    this.author,
    this.poster,
    this.status,
    this.updatedDate,
    this.categories,
    this.description,
    this.rateCount = 0.0,
  });

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
      categories: StoryBookHelper.buildCategories(json['categoryList'] ?? []),
      rateCount: json['rateCount'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
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
