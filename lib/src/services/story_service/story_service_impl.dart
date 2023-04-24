import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_config_constants.dart';
import '../../models/story_book.dart';
import '../../shared/constants/app_constants.dart' as constants;
import 'story_service.dart';

class StoryServiceImpl implements StoryService {
  final http.Client client;

  StoryServiceImpl(this.client);

  @override
  Future<StoryBook?> getStoryDetail(int storyId) async {
    final String path =
        "${AppConfig.instance.getValue(AppConfigConstants.GET_STORY_DETAIL_PATH)}/$storyId";
    try {
      final uri = Uri(
        scheme: 'https',
        host: AppConfig.instance.getValue(AppConfigConstants.HOST_NAME),
        path: path,
      );
      final response = await httpClient.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = StoryBook.fromJson(data);
        return result;
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
}
