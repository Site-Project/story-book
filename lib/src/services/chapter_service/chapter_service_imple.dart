import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_config_constants.dart';
import '../../models/chapter.dart';
import '../../shared/constants/app_constants.dart' as constants;
import 'chapter_service.dart';

class ChapterServiceImpl implements ChapterService {
  final http.Client client;

  ChapterServiceImpl(this.client);

  @override
  http.Client get httpClient => client;

  @override
  Future<Chapter?> getChapterDetail(int chapterId) async {
    final String path =
        "${AppConfig.instance.getValue(AppConfigConstants.GET_CHAPTER_DETAIL_PATH)}/$chapterId";
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
        final result = Chapter.fromJson(data);
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
}
