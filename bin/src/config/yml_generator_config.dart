import 'package:yaml/yaml.dart';

import '../model/field.dart';
import '../model/item_type/array_type.dart';
import '../model/item_type/boolean_type.dart';
import '../model/item_type/date_time_type.dart';
import '../model/item_type/date_type.dart';
import '../model/item_type/double_type.dart';
import '../model/item_type/dynamic_type.dart';
import '../model/item_type/integer_type.dart';
import '../model/item_type/item_type.dart';
import '../model/item_type/object_type.dart';
import '../model/item_type/string_type.dart';
import '../model/model.dart';
import '../util/type_checker.dart';

class YmlGeneratorConfig {
  final models = List<Model>();

  YmlGeneratorConfig(String configContent) {
    loadYaml(configContent).forEach((key, value) {
      final requiredFields = getRequiredFields(value);
      final YamlMap properties = value['properties'];
      final fields = List<Field>();
      properties.forEach((key, value) => fields.add(getField(key, value, requiredFields)));
      models.add(Model(key, fields));
    });

    checkIfTypesAvailable();
  }

  List<String> getRequiredFields(YamlMap model) {
    final YamlList requiredProperties = model['required'];
    final requiredFields = List<String>();
    requiredProperties.forEach((key) {
      if (requiredFields.contains(key)) {
        throw Exception('Field is already added. This is unsupported');
      }
      requiredFields.add(key);
    });
    return requiredFields;
  }

  Field getField(String name, YamlMap property, List<String> requiredFields) {
    final required = requiredFields.contains(name);
    final type = property['type'];
    ItemType itemType;

    if (type != null) {
      if (type == 'object') {
        itemType = DynamicType();
      } else if (type == 'boolean') {
        itemType = BooleanType();
      } else if (type == 'string') {
        final format = property['format'];
        if (format == null) {
          itemType = StringType();
        } else if (format == 'date-time') {
          print('A date time formatter should be added in the config for : `$name`');
          itemType = DateTimeType();
        } else if (format == 'date') {
          print('A date formatter should be added in the config for : `$name`');
          itemType = DateType();
        }
      } else if (type == 'array') {
        final items = property['items'];
        final arrayType = items['type'];
        if (arrayType != null) {
          if (arrayType == 'string') {
            itemType = ArrayType('String');
          } else {
            itemType = ArrayType(arrayType);
          }
        } else {
          final ref = items['\$ref'];
          itemType = ArrayType(ref);
        }
      } else {
        final format = property['format'];
        if (format == 'int32') {
          itemType = IntegerType();
        } else if (format == 'double') {
          itemType = DoubleType();
        } else {
          throw Exception();
        }
      }
    }
    final ref = property['\$ref'];
    if (ref != null) {
      itemType = ObjectType(ref);
    }
    return Field(name, itemType, required);
  }

  void checkIfTypesAvailable() {
    final names = List<String>();
    final types = List<String>();
    models.forEach((model) {
      if (!names.contains(model.name)) {
        names.add(model.name);
      }
      model.fields.forEach((field) {
        if (!types.contains(field.type.name)) {
          types.add(field.type.name);
        }
      });
    });

    print(names);
    print('=======');
    print(types);
    types.forEach((type) {
      if (!TypeChecker.isPrimitiveType(type) && !names.contains(type)) {
        throw Exception('Could not generate all models. `$type` is not added to the config file');
      }
    });
  }
}
