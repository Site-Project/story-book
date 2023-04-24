import 'package:http/http.dart' as http;

import '../../models/chapter.dart';
import '../../models/story_book.dart';

abstract class StoryService {
  final http.Client httpClient;

  StoryService({required this.httpClient});

  Future<StoryBook?> getStoryDetail(int storyId);

  Future<List<Chapter>?> getChapterByStory(String slug);
}
