import 'iterable_helper.dart';
import 'string_helper.dart';

class ChapterHelper {
  static List<String> buildBody(List<dynamic> listDesc) {
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
}
