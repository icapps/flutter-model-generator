class TypeChecker {
  static bool isKnownDartType(type) {
    return type == 'DateTime' ||
        type == 'String' ||
        type == 'int' ||
        type == 'number' ||
        type == 'double' ||
        type == 'bool';
  }

  static bool isString(value) {
    return value is String;
  }
}
