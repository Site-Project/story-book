import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_config_constants.dart';
import '../../models/category_book.dart';
import 'category_service.dart';

class CategoryServiceImpl implements CategoryService {
  final http.Client client;

  CategoryServiceImpl(this.client);

  @override
  Future<List<CategoryBook>?> getCategories() async {
    try {
      final uri = Uri(
        scheme: 'https',
        host: AppConfig.instance.getValue(AppConfigConstants.HOST_NAME),
        path: AppConfig.instance
            .getValue(AppConfigConstants.GET_CATEGORY_LIST_PATH),
      );
      final response = await httpClient.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<CategoryBook> results = [];
        for (var element in data) {
          results.add(CategoryBook.fromJson(element));
        }
        return results;
      } else {
        throw (Exception(
            'Has an error with static code ${response.statusCode}'));
      }
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  @override
  http.Client get httpClient => client;
}
