class KeywordHelper {
  KeywordHelper._();

  static String getCorrectKeyword(String value) {
    final list = [
      'assert',
      'enum',
      'in',
      'superasync',
      'export',
      'interface',
      'switch',
      'await',
      'extends',
      'is',
      'sync',
      'break',
      'external',
      'library',
      'this',
      'case',
      'factory',
      'mixin',
      'throw',
      'catch',
      'false',
      'new',
      'true',
      'class',
      'final',
      'null',
      'try',
      'const',
      'finally',
      'on',
      'typedef',
      'continue',
      'for',
      'operator',
      'var',
      'covariant',
      'Function',
      'part',
      'void',
      'default',
      'get',
      'rethrow',
      'while',
      'deferred',
      'hide',
      'return',
      'with',
      'do',
      'if',
      'set',
      'yield ',
      '',
    ];
    if (list.contains(value)) {
      return '${value}Value';
    }
    return value;
  }
}
