import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/list_extensions.dart';

class ObjectModelWriterUtil {
  ObjectModelWriterUtil._();

  static List<Field> getExtendedFields(ObjectModel model, YmlGeneratorConfig ymlConfig) {
    final extendsModelfields = <Field>[];
    var extendsModelextends = model.extendsModel;
    while (extendsModelextends != null) {
      final extendsModelextendsModel = ymlConfig.models.firstWhereOrNull((element) => element.name == extendsModelextends) as ObjectModel?; // ignore: avoid_as
      extendsModelfields.addAll(extendsModelextendsModel?.fields ?? []);
      extendsModelextends = extendsModelextendsModel?.extendsModel;
    }
    return extendsModelfields;
  }
}
