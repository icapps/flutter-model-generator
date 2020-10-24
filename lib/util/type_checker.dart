class TypeChecker {
  static bool isKnownDartType(String type) {
    return type == 'DateTime' ||
        type == 'String' ||
        type == 'int' ||
        type == 'number' ||
        type == 'double' ||
        type == 'dynamic' ||
        type == 'bool';
  }
}
