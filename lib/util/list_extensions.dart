extension ListExtenstion<T> on List<T> {
  T? firstWhereOrNull(bool test(T element)) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
