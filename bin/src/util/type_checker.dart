class TypeChecker {
  static bool isKnownDartType(type) {
    return type == 'DateTime' || type == 'String' || type == 'integer' || type == 'number' || type == 'double' || type == 'boolean';
  }

  static bool isString(value) {
    return value is String;
  }
}
