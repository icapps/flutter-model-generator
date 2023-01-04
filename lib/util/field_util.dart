import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/list_extensions.dart';

class FieldUtil {
  static List<Field> getExtendedFields(
      ObjectModel model, YmlGeneratorConfig ymlConfig) {
    final extendsModelfields = <Field>[];
    var extendsModelextends = model.extendsModel;
    while (extendsModelextends != null) {
      final extendsModelextendsModel = ymlConfig.models.firstWhereOrNull(
              (element) => element.name == extendsModelextends)
          as ObjectModel?; // ignore: avoid_as
      extendsModelfields.addAll(extendsModelextendsModel?.fields ?? []);
      extendsModelextends = extendsModelextendsModel?.extendsModel;
    }
    return extendsModelfields;
  }

  static List<Field> getEnumFields(
      ObjectModel model, YmlGeneratorConfig ymlConfig) {
    final enumFields = <Field>[];
    for (final field
        in model.fields.where((element) => !element.ignoreForTable)) {
      final fieldModel = ymlConfig.models
          .firstWhereOrNull((element) => element.name == field.type.name);
      if (fieldModel is EnumModel) {
        enumFields.add(field);
      }
    }
    return enumFields;
  }
}
