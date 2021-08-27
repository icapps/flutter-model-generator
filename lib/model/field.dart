import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/util/case_util.dart';
import 'package:model_generator/util/keyword_helper.dart';

class Field {
  final String name;
  final String serializedName;
  final ItemType type;
  final bool isRequired;
  final bool ignore;
  final bool includeIfNull;
  final bool nonFinal;
  final String? unknownEnumValue;
  final String? description;

  Field({
    required String name,
    required this.type,
    required this.isRequired,
    required this.ignore,
    required this.includeIfNull,
    required this.nonFinal,
    this.description,
    this.unknownEnumValue,
    String? jsonKey,
  })  : serializedName = jsonKey ?? name,
        name =
            CaseUtil(KeywordHelper.instance.getCorrectKeyword(name)).camelCase;
}
