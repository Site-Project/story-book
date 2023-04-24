import 'package:http/http.dart' as http;

import '../../models/chapter.dart';

abstract class ChapterService {
  final http.Client httpClient;

  ChapterService({required this.httpClient});

  Future<Chapter?> getChapterDetail(int storyId);
}
