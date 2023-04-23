import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_config_constants.dart';
import '../../models/category_book.dart';
import 'category_service.dart';

class CategoryServiceImpl implements CategoryService {
  final http.Client client;

  CategoryServiceImpl(this.client);

  @override
  Future<List<CategoryBook>> getCategories() async {
    try {
      final uri = Uri(
        scheme: 'https',
        host: AppConfig.instance.getValue(AppConfigConstants.HOST_NAME),
        path: AppConfig.instance
            .getValue(AppConfigConstants.GET_CATEGORY_LIST_PATH),
      );
      final data = await httpClient.get(uri);
      if (data.statusCode == 200) {
        data;
      }
    } catch (e) {
      throw (e);
    }

    return [];
  }

  @override
  http.Client get httpClient => client;
}
