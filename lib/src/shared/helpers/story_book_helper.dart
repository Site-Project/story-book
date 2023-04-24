import 'iterable_helper.dart';
import 'string_helper.dart';

class StoryBookHelper {
  static List<String> buildDescription(List<dynamic> listDesc) {
    final List<String> result = [];
    if (IterableHelper.isNotNullOrEmpty(listDesc)) {
      for (var element in listDesc) {
        if (StringHelper.isNotNullOrEmpty(element.toString())) {
          result.add(element);
        }
      }
    }
    return result;
  }

  static List<String> buildCategories(List<dynamic> listCategories) {
    final List<String> result = [];
    if (IterableHelper.isNotNullOrEmpty(listCategories)) {
      for (var element in listCategories) {
        result.add(element.toString());
      }
    }
    return result;
  }
}
