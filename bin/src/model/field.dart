import '../util/keyword_helper.dart';
import 'item_type/item_type.dart';

class Field {
  String name;
  String serializedName;
  final ItemType type;
  final bool required;

  String path;

  Field(String name, this.type, this.required) {
    // ignore: prefer_initializing_formals
    serializedName = name;
    this.name = KeywordHelper.getCorrectKeyword(name);
  }

  @override
  String toString() {
    return 'Field{name: $name, type: $type, required: $required, path: $path}';
  }
}
