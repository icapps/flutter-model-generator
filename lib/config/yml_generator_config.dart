import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/boolean_type.dart';
import 'package:model_generator/model/item_type/date_time_type.dart';
import 'package:model_generator/model/item_type/double_type.dart';
import 'package:model_generator/model/item_type/dynamic_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/model/item_type/object_type.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/custom_from_to_json_model.dart';
import 'package:model_generator/model/model/custom_model.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/model/model/json_converter_model.dart';
import 'package:model_generator/model/model/model.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/generic_type.dart';
import 'package:model_generator/util/list_extensions.dart';
import 'package:model_generator/util/type_checker.dart';
import 'package:yaml/yaml.dart';

class YmlGeneratorConfig {
  final _models = <Model>[];

  List<Model> get models => _models;

  YmlGeneratorConfig(PubspecConfig pubspecConfig, String configContent) {
    loadYaml(configContent).forEach((key, value) {
      final String baseDirectory =
          value['base_directory'] ?? pubspecConfig.baseDirectory;
      final String? path = value['path'];
      final bool generateForGenerics =
          value['generate_for_generics'] ?? pubspecConfig.generateForGenerics;

      final extraImports =
          value.containsKey('extra_imports') ? <String>[] : null;
      final extraImportsVal = value['extra_imports'];
      extraImportsVal?.forEach((e) {
        if (e != null) {
          extraImports!.add(e.toString());
        }
      });

      final extraAnnotations =
          value.containsKey('extra_annotations') ? <String>[] : null;
      final extraAnnotationsVal = value['extra_annotations'];
      extraAnnotationsVal?.forEach((e) {
        if (e != null) {
          extraAnnotations!.add(e.toString());
        }
      });

      final dynamic properties = value['properties'];
      final YamlList? converters = value['converters'];
      final String? type = value['type'];
      if (type == 'custom') {
        models.add(CustomModel(
          name: key,
          path: path,
          baseDirectory: baseDirectory,
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
        ));
        return;
      } else if (type == 'custom_from_to_json') {
        models.add(CustomFromToJsonModel(
          name: key,
          path: path,
          baseDirectory: baseDirectory,
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
        ));
        return;
      } else if (type == 'json_converter') {
        models.add(JsonConverterModel(
          name: key,
          path: path,
          baseDirectory: baseDirectory,
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
        ));
        return;
      }
      if (properties == null) {
        throw Exception('Properties can not be null. model: $key');
      }
      if (!(properties is YamlMap)) {
        throw Exception(
            'Properties should be a map, right now you are using a ${properties.runtimeType}. model: $key');
      }
      if (type == 'enum') {
        final fields = <EnumField>[];
        properties.forEach((propertyKey, propertyValue) {
          if (propertyValue != null && !(propertyValue is YamlMap)) {
            throw Exception('$propertyKey should be an object');
          }
          fields.add(EnumField(
            name: propertyKey,
            value: propertyValue == null ? null : propertyValue['value'],
            description:
                propertyValue == null ? null : propertyValue['description'],
          ));
        });
        models.add(EnumModel(
          name: key,
          path: path,
          generateMap: value['generate_map'] == true,
          generateExtensions: value['generate_extensions'] == true,
          baseDirectory: baseDirectory,
          fields: fields,
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
        ));
      } else {
        final fields = <Field>[];
        properties.forEach((propertyKey, propertyValue) {
          if (!(propertyValue is YamlMap)) {
            throw Exception('$propertyKey should be an object');
          }
          fields.add(getField(propertyKey, propertyValue));
        });
        final mappedConverters =
            converters?.map((element) => element.toString()).toList();
        models.add(ObjectModel(
          name: key,
          path: path,
          baseDirectory: baseDirectory,
          generateForGenerics: generateForGenerics,
          fields: fields,
          converters: mappedConverters ?? [],
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
          equalsAndHashCode: value['equals_and_hash_code'],
          explicitToJson: value['explicit_to_json'],
          generateToString: value['to_string'],
        ));
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
      final nonFinal = ignored ||
          property.containsKey('non_final') && property['non_final'] == true;
      final includeIfNull = property.containsKey('include_if_null') &&
          property['include_if_null'] == true;
      final unknownEnumValue = property['unknown_enum_value'];
      final jsonKey = property['jsonKey'] ?? property['jsonkey'];
      final fromJson = property['fromJson'];
      final toJson = property['toJson'];
      final description = property.containsKey('description')
          ? property['description']!.toString()
          : null;
      final type = property['type'];
      ItemType itemType;

      if (type == null) {
        throw Exception('$name has no defined type');
      }
      if (type == 'object' || type == 'dynamic' || type == 'any') {
        itemType = DynamicType();
      } else if (type == 'bool' || type == 'boolean') {
        itemType = BooleanType();
      } else if (type == 'string' || type == 'String') {
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
        itemType = ArrayType(_makeGenericName(arrayType));
      } else if (type == 'map') {
        final items = property['items'];
        final keyType = items['key'];
        final valueType = items['value'];
        itemType = MapType(
          key: _makeGenericName(keyType),
          valueName: _makeGenericName(valueType),
        );
      } else {
        itemType = ObjectType(type);
      }
      return Field(
        name: name,
        type: itemType,
        isRequired: required,
        ignore: ignored,
        jsonKey: jsonKey,
        nonFinal: nonFinal,
        description: description,
        includeIfNull: includeIfNull,
        unknownEnumValue: unknownEnumValue,
        fromJson: fromJson,
        toJson: toJson,
      );
    } catch (e) {
      print('Something went wrong with $name:\n\n${e.toString()}');
      rethrow;
    }
  }

  String _makeGenericName(String typeName) {
    if (typeName == 'string' || typeName == 'String') {
      return 'String';
    } else if (typeName == 'bool' || typeName == 'boolean') {
      return 'bool';
    } else if (typeName == 'double') {
      return 'double';
    } else if (typeName == 'date' || typeName == 'datetime') {
      return 'DateTime';
    } else if (typeName == 'int' || typeName == 'integer') {
      return 'int';
    } else if (typeName == 'object' ||
        typeName == 'dynamic' ||
        typeName == 'any') {
      return 'dynamic';
    } else {
      return typeName;
    }
  }

  Iterable<String> getPathsForName(PubspecConfig pubspecConfig, String name) {
    if (TypeChecker.isKnownDartType(name)) return [];

    final foundModel = models.firstWhereOrNull((model) => model.name == name);
    if (foundModel == null) {
      //Maybe a generic
      final dartType = DartType(name);
      if (dartType.generics.isEmpty) {
        throw Exception(
            'getPathForName is null: because `$name` was not added to the config file');
      }
      final paths = <String>{};
      dartType.generics.forEach((element) {
        paths.addAll(getPathsForName(pubspecConfig, element.toString()));
      });
      return paths;
    } else {
      final baseDirectory =
          foundModel.baseDirectory ?? pubspecConfig.baseDirectory;
      final path = foundModel.path;
      if (path == null) {
        return ['$baseDirectory'];
      } else if (path.startsWith('package:')) {
        return [path];
      } else {
        return ['$baseDirectory/$path'];
      }
    }
  }

  void checkIfTypesAvailable() {
    final names = <String>{};
    final types = <String>{};
    models.forEach((model) {
      names.add(model.name);
      if (model is ObjectModel) {
        model.fields.forEach((field) {
          final type = field.type;
          types.add(type.name);
          if (type is MapType) {
            types.add(type.valueName);
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
      DartType(type).checkTypesKnown(names);
    });
  }

  Model? getModelByName(ItemType itemType) {
    if (itemType is! ObjectType) return null;
    final model =
        models.firstWhereOrNull((model) => model.name == itemType.name);
    if (model == null) {
      throw Exception(
          'getModelByname is null: because `${itemType.name}` was not added to the config file');
    }
    return model;
  }
}
