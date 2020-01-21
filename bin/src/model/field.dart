import '../util/keyword_helper.dart';
import 'item_type/item_type.dart';

class Field {
  final String name;
  final String serializedName;
  final ItemType type;
  final bool required;

  String path;

  Field(String name, this.type, this.required)
      // ignore: prefer_initializing_formals
      : serializedName = name,
        name = KeywordHelper.getCorrectKeyword(name).replaceAll('_', '');
}
