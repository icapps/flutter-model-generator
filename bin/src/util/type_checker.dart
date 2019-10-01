class TypeChecker {
  static bool isPrimitiveType(type) {
    return type == 'String' ||
        type == 'integer' ||
        type == 'number' ||
        type == 'boolean';
  }

  static bool isString(value) {
    return value is String;
  }
}
