import '../util/case_util.dart';
import '../util/keyword_helper.dart';
import 'item_type/item_type.dart';

class Field {
  final String name;
  final String serializedName;
  final ItemType type;
  final bool required;
  final bool ignore;
  final bool includeIfNull;
  final bool nonFinal;

  Field(
      {String name,
      this.type,
      this.required,
      this.ignore,
      this.includeIfNull,
      this.nonFinal,
      String jsonKey})
      // ignore: prefer_initializing_formals
      : serializedName = jsonKey ?? name,
        name = CaseUtil(KeywordHelper.getCorrectKeyword(name)).camelCase;
}
