import 'package:http/http.dart' as http;

import '../../models/category.dart';

abstract class CategoryService {
  final http.Client httpClient;

  CategoryService({required this.httpClient});

  Future<List<Category>> getCategories();
}
