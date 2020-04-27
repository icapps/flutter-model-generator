import '../util/keyword_helper.dart';
import 'item_type/item_type.dart';

class Field {
  final String name;
  final String serializedName;
  final ItemType type;
  final bool required;
  final bool ignore;

  String _path;

  set path(String path) {
    if (path != null && path.endsWith('/')) {
      _path = path.substring(0, path.length - 1);
    } else {
      _path = path;
    }
  }

  String get path => _path;

  Field({String name, this.type, this.required, this.ignore})
      // ignore: prefer_initializing_formals
      : serializedName = name,
        name = KeywordHelper.getCorrectKeyword(name).replaceAll('_', '');
}
