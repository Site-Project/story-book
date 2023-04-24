import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_config_constants.dart';
import '../../models/chapter.dart';
import '../../models/story_book.dart';
import '../../shared/constants/app_constants.dart' as constants;
import 'story_service.dart';

class StoryServiceImpl implements StoryService {
  final http.Client client;

  StoryServiceImpl(this.client);

  @override
  http.Client get httpClient => client;

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
      final response =
          await httpClient.get(uri).timeout(const Duration(seconds: 10));
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
  Future<List<Chapter>?> getChapterByStory(String slug) async {
    final String path = _buildChapterByStoryPath(slug);
    try {
      final uri = Uri(
        scheme: 'https',
        host: AppConfig.instance.getValue(AppConfigConstants.HOST_NAME),
        path: path,
      );
      final response =
          await httpClient.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        List<Chapter> chapters = [];
        final data = json.decode(response.body);
        for (var element in data) {
          chapters.add(Chapter.fromJson(element));
        }
        return chapters;
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

  String _buildChapterByStoryPath(String slug) {
    final String chappterByStoryPath = AppConfig.instance
        .getValue(AppConfigConstants.GET_CHAPTER_LIST_BY_STORY_PATH);

    String fillIdPath = chappterByStoryPath.replaceAll(RegExp(r'#SLUG#'), slug);
    return fillIdPath;
  }
}
