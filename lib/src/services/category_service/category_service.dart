import 'package:http/http.dart' as http;

import '../../models/category_book.dart';

abstract class CategoryService {
  final http.Client httpClient;

  CategoryService({required this.httpClient});

  Future<List<CategoryBook>?> getCategories();
}
