import 'package:yaml/yaml.dart';

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
import '../model/model/custom_from_to_json_model.dart';
import '../model/model/custom_model.dart';
import '../model/model/enum_model.dart';
import '../model/model/json_converter_model.dart';
import '../model/model/model.dart';
import '../model/object_model.dart';
import '../util/type_checker.dart';
import 'pubspec_config.dart';

class YmlGeneratorConfig {
  static final _models = <Model>[];

  List<Model> get models => _models;

  YmlGeneratorConfig(PubspecConfig pubspecConfig, String configContent) {
    loadYaml(configContent).forEach((key, value) {
      final String baseDirectory =
          value['base_directory'] ?? pubspecConfig.baseDirectory;
      final String path = value['path'];
      final YamlMap properties = value['properties'];
      final YamlList converters = value['converters'];
      final String type = value['type'];
      if (type == 'custom') {
        models.add(CustomModel(key, path, baseDirectory));
        return;
      } else if (type == 'custom_from_to_json') {
        models.add(CustomFromToJsonModel(key, path, baseDirectory));
        return;
      } else if (type == 'json_converter') {
        models.add(JsonConverterModel(key, path, baseDirectory));
        return;
      }
      if (properties == null) {
        throw Exception('Properties can not be null. model: $key');
      }
      if (type == 'enum') {
        final fields = <EnumField>[];
        properties.forEach((propertyKey, propertyValue) {
          if (propertyValue != null && !(propertyValue is YamlMap)) {
            throw Exception('$propertyValue should be an object');
          }
          fields.add(EnumField(propertyKey,
              propertyValue == null ? '' : propertyValue['value']));
        });
        models.add(EnumModel(key, path, baseDirectory, fields));
      } else {
        final fields = <Field>[];
        properties.forEach((propertyKey, propertyValue) {
          if (!(propertyValue is YamlMap)) {
            throw Exception('$propertyValue should be an object');
          }
          fields.add(getField(propertyKey, propertyValue));
        });
        final mappedConverters =
            converters?.map((element) => element as String)?.toList() ??
                <String>[];
        models.add(
            ObjectModel(key, path, baseDirectory, fields, mappedConverters));
      }
    });

    checkIfTypesAvailable();
  }

  Field getField(String name, YamlMap property) {
    try {
      final required =
          property.containsKey('required') && property['required'] == true;
      final ignored =
          property.containsKey('ignore') && property['ignore'] == true;
      final includeIfNull = property.containsKey('includeIfNull') &&
          property['includeIfNull'] == false;
      final nonFinal = ignored ||
          property.containsKey('non_final') && property['non_final'] == true;
      final jsonKey = property['jsonKey'] ?? property['jsonkey'];
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
      return Field(
        name: name,
        type: itemType,
        required: required,
        ignore: ignored,
        jsonKey: jsonKey,
        nonFinal: nonFinal,
        includeIfNull: includeIfNull,
      );
    } catch (e) {
      print('Something went wrong with $name:\n\n${e.toString()}');
      rethrow;
    }
  }

  String getPathForField(PubspecConfig pubspecConfig, Field field) {
    return getPathForName(pubspecConfig, field.type.name);
  }

  String getPathForName(PubspecConfig pubspecConfig, String name) {
    final foundModel =
        models.firstWhere((model) => model.name == name, orElse: () => null);
    if (foundModel == null) return null;
    final baseDirectory =
        foundModel.baseDirectory ?? pubspecConfig.baseDirectory;
    if (foundModel.path == null) {
      return '$baseDirectory';
    } else {
      return '$baseDirectory/${foundModel.path}';
    }
  }

  void checkIfTypesAvailable() {
    final names = <String>[];
    final types = <String>[];
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

    print('Registered models:');
    print(names);
    print('=======');
    print('Models used as a field in another model:');
    print(types);
    types.forEach((type) {
      if (!TypeChecker.isKnownDartType(type) && !names.contains(type)) {
        throw Exception(
            'Could not generate all models. `$type` is not added to the config file');
      }
    });
  }

  static Model getModelByName(ItemType itemType) {
    if (itemType is! ObjectType) return null;
    final model = _models.firstWhere((element) => element.name == itemType.name,
        orElse: () => null);
    if (model == null) {
      throw ArgumentError('getModelByname is null: given name: `$itemType`');
    }
    return model;
  }
}
