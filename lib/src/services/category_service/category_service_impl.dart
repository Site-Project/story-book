import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_config_constants.dart';
import '../../models/category_book.dart';
import '../../models/story_book.dart';
import '../../shared/constants/app_constants.dart' as constants;
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
      final response =
          await httpClient.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<CategoryBook> results = [];
        for (var element in data) {
          results.add(CategoryBook.fromJson(element));
        }
        return results;
      } else {
        String errorMgs = constants.ErrorMessage.requestError.replaceAll(
            RegExp(r'#StaticCode#'), response.statusCode.toString());
        log(errorMgs);
        throw (Exception(errorMgs));
      }
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  @override
  http.Client get httpClient => client;

  @override
  Future<List<StoryBook>?> getStoriesByCategory({
    required int categoryId,
    int page = 0,
  }) async {
    final String path = _buildStoriesByCategoryPath(categoryId);
    final limitItem =
        AppConfig.instance.getValue(AppConfigConstants.NUM_OF_LIMIT_ITEM);

    final String query = 'page=$page&limit=${int.tryParse(limitItem)}';

    try {
      final uri = Uri(
        scheme: 'https',
        host: AppConfig.instance.getValue(AppConfigConstants.HOST_NAME),
        path: path,
        query: query,
      );
      final response =
          await httpClient.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<StoryBook> results = [];
        for (var element in data) {
          results.add(StoryBook.fromJson(element));
        }
        return results;
      } else {
        String errorMgs = constants.ErrorMessage.requestError.replaceAll(
            RegExp(r'#StaticCode#'), response.statusCode.toString());
        log(errorMgs);
        throw (Exception(errorMgs));
      }
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  String _buildStoriesByCategoryPath(int id) {
    final String categoryPath =
        AppConfig.instance.getValue(AppConfigConstants.GET_CATEGORY_LIST_PATH);
    final String storyByCategoryPath = AppConfig.instance
        .getValue(AppConfigConstants.GET_STORY_LIST_BY_CATEGORY_PATH);

    String fillIdPath =
        storyByCategoryPath.replaceAll(RegExp(r'#ID#'), id.toString());
    return "$categoryPath/$fillIdPath";
  }
}
