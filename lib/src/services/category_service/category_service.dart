import 'package:http/http.dart' as http;
import 'package:storybook/src/models/story_book.dart';

import '../../models/category_book.dart';

abstract class CategoryService {
  final http.Client httpClient;

  CategoryService({required this.httpClient});

  Future<List<CategoryBook>?> getCategories();
  Future<List<StoryBook>?> getStoriesByCategory({
    required int categoryId,
    int page = 0,
  });
}
