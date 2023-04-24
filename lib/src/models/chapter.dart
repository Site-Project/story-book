import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  final int id;
  final String slug;
  final String? header;
  final String? body;

  const Chapter({
    required this.id,
    required this.slug,
    this.header,
    this.body,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    assert(json['id'] != null && json['slug'] != null);
    return Chapter(
      id: json['id'],
      slug: json['slug'],
      header: json['header'] ?? '',
      body: json['body'] ?? '...',
    );
  }

  @override
  List<Object?> get props => [
        id,
        slug,
        header,
        body,
      ];
}
