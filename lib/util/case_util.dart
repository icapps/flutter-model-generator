class CaseUtil {
  final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');
  final RegExp _symbolRegex = RegExp(r'[ ./_\-]');

  late String originalText;
  late List<String> _words;

  CaseUtil(String text) {
    // ignore: prefer_initializing_formals
    originalText = text;
    _words = _groupIntoWords(text);
  }

  List<String> _groupIntoWords(String text) {
    final sb = StringBuffer();
    final words = <String>[];
    final isAllCaps = !text.contains(RegExp('[a-z]'));

    for (var i = 0; i < text.length; i++) {
      final char = String.fromCharCode(text.codeUnitAt(i));
      final nextChar = i + 1 == text.length
          ? null
          : String.fromCharCode(text.codeUnitAt(i + 1));

      if (_symbolRegex.hasMatch(char)) {
        continue;
      }

      sb.write(char);

      final isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          _symbolRegex.hasMatch(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }

  String get snakeCase => _getSnakeCase();

  String get camelCase => _getCamelCase();

  String _getSnakeCase({String separator = '_'}) =>
      _words.map((word) => word.toLowerCase()).toList().join(separator);

  String _getCamelCase({String separator = ''}) {
    final words = _words.map(_upperCaseFirstLetter).toList();
    words[0] = words[0].toLowerCase();

    return words.join(separator);
  }

  static String _upperCaseFirstLetter(String word) {
    return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
  }
}
