class IterableHelper {
  static isNullOrEmpty(Iterable? iterable) {
    return iterable == null || iterable.isEmpty;
  }

  static isNotNullOrEmpty(Iterable? iterable) => !isNullOrEmpty(iterable);
}
