import 'package:yaml/yaml.dart';

import '../model/enum_model.dart';
import '../model/field.dart';
import '../model/item_type/array_type.dart';
import '../model/item_type/boolean_type.dart';
import '../model/item_type/date_time_type.dart';
import '../model/item_type/double_type.dart';
import '../model/item_type/dynamic_type.dart';
import '../model/item_type/integer_type.dart';
import '../model/item_type/item_type.dart';
import '../model/item_type/object_type.dart';
import '../model/item_type/string_type.dart';
import '../model/model.dart';
import '../model/object_model.dart';
import '../util/type_checker.dart';

class YmlGeneratorConfig {
  final models = List<Model>();

  YmlGeneratorConfig(String configContent) {
    loadYaml(configContent).forEach((key, value) {
      final String path = value['path'];
      final YamlMap properties = value['properties'];
      final String type = value['type'];
      if (properties == null) {
        throw Exception('Properties can not be null. model: $key');
      }
      if (type == 'object') {
        final fields = List<Field>();
        properties.forEach((propertyKey, propertyValue) {
          if (!(propertyValue is YamlMap)) {
            throw Exception('$propertyValue should be an object');
          }
          fields.add(getField(propertyKey, propertyValue));
        });
        models.add(ObjectModel(key, path, fields));
      } else {
        final fields = List<EnumField>();
        properties.forEach((propertyKey, propertyValue) {
          if (propertyValue != null && !(propertyValue is YamlMap)) {
            throw Exception('$propertyValue should be an object');
          }
          fields.add(EnumField(propertyKey, propertyValue == null ? '' : propertyValue['value']));
        });
        models.add(EnumModel(key, path, fields));
      }
    });

    checkIfTypesAvailable();
    addPathsToFields();
  }

  Field getField(String name, YamlMap property) {
    try {
      final required = property.containsKey('required') && property['required'] == true;
      final ignored = property.containsKey('ignore') && property['ignore'] == true;
      final type = property['type'];
      ItemType itemType;

      if (type != null) {
        if (type == 'object' || type == 'dynamic' || type == 'any') {
          itemType = DynamicType();
        } else if (type == 'bool' || type == 'boolean') {
          itemType = BooleanType();
        } else if (type == 'string') {
          itemType = StringType();
        } else if (type == 'date' || type == 'datetime') {
          itemType = DateTimeType();
        } else if (type == 'double') {
          itemType = DoubleType();
        } else if (type == 'int' || type == 'integer') {
          itemType = IntegerType();
        } else if (type == 'array') {
          final items = property['items'];
          final arrayType = items['type'];
          if (arrayType == 'string') {
            itemType = ArrayType('String');
          } else if (arrayType == 'boolean') {
            itemType = ArrayType('bool');
          } else if (arrayType == 'date' || arrayType == 'datetime') {
            itemType = ArrayType('DateTime');
          } else if (arrayType == 'integer' || arrayType == 'int') {
            itemType = ArrayType('int');
          } else if (arrayType == 'object' || arrayType == 'any') {
            itemType = ArrayType('dynamic');
          } else {
            itemType = ArrayType(arrayType);
          }
        } else {
          itemType = ObjectType(type);
        }
      }
      final ref = property['\$ref'];
      if (ref != null) {
        itemType = ObjectType(ref);
      }
      return Field(name: name, type: itemType, required: required, ignore: ignored);
    } catch (e) {
      print('Something went wrong with $name:\n\n${e.toString()}');
      rethrow;
    }
  }

  void addPathsToFields() {
    models.forEach((model) {
      if (model is ObjectModel) {
        model.fields.forEach((field) {
          final foundModels = models.where((model) => model.name == field.type.name).toList();
          if (foundModels.isNotEmpty) {
            field.path = foundModels[0].path;
          }
        });
      } else if (model is EnumModel) {}
    });
  }

  void checkIfTypesAvailable() {
    final names = List<String>();
    final types = List<String>();
    models.forEach((model) {
      if (!names.contains(model.name)) {
        names.add(model.name);
      }
      if (model is ObjectModel) {
        model.fields.forEach((field) {
          if (!types.contains(field.type.name)) {
            types.add(field.type.name);
          }
        });
      }
    });

    print(names);
    print('=======');
    print(types);
    types.forEach((type) {
      if (!TypeChecker.isKnownDartType(type) && !names.contains(type)) {
        throw Exception('Could not generate all models. `$type` is not added to the config file');
      }
    });
  }
}
