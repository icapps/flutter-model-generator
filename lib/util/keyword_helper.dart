import 'package:meta/meta.dart';

class KeywordHelper {
  @visibleForTesting
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
  static KeywordHelper? _instance;

  static get instance => _instance ??= KeywordHelper._();

  KeywordHelper._();

  String getCorrectKeyword(String value) {
    if (list.contains(value)) {
      return '${value}Value';
    }
    return value;
  }
}
