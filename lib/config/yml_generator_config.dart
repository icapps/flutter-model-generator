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
      final String? extendsModel = value['extends'];
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

      final description = value['description']?.toString();
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
      if (properties is! YamlMap) {
        throw Exception(
            'Properties should be a map, right now you are using a ${properties.runtimeType}. model: $key');
      }
      if (type == 'enum') {
        final uppercaseEnums =
            (value['uppercase_enums'] ?? pubspecConfig.uppercaseEnums) == true;

        final fields = <EnumField>[];
        properties.forEach((propertyKey, propertyValue) {
          if (propertyValue != null && propertyValue is! YamlMap) {
            throw Exception('$propertyKey should be an object');
          }
          fields.add(EnumField(
            name: uppercaseEnums ? propertyKey.toUpperCase() : propertyKey,
            rawName: propertyKey,
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
          description: description,
        ));
      } else {
        final staticCreate = (value['static_create'] ?? false) == true;
        final disallowNullForDefaults =
            value.containsKey('disallow_null_for_defaults')
                ? (value['disallow_null_for_defaults'] == true)
                : pubspecConfig.disallowNullForDefaults;
        final fields = <Field>[];
        properties.forEach((propertyKey, propertyValue) {
          if (propertyValue is YamlMap) {
            fields.add(getField(propertyKey, propertyValue,
                disallowNullForDefaults: disallowNullForDefaults));
          } else if (propertyValue is String) {
            fields.add(getSimpleField(name: propertyKey, value: propertyValue));
          } else {
            throw Exception('$propertyKey should be an object');
          }
        });
        final mappedConverters =
            converters?.map((element) => element.toString()).toList();
        models.add(ObjectModel(
          name: key,
          path: path,
          extendsModel: extendsModel,
          baseDirectory: baseDirectory,
          generateForGenerics: generateForGenerics,
          fields: fields,
          converters: mappedConverters ?? [],
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
          staticCreate: staticCreate,
          equalsAndHashCode: value['equals_and_hash_code'],
          explicitToJson: value['explicit_to_json'],
          generateToString: value['to_string'],
          description: description,
          disallowNullForDefaults: disallowNullForDefaults,
        ));
      }
    });

    checkIfTypesAvailable();
  }

  Field getField(String name, YamlMap property,
      {required bool disallowNullForDefaults}) {
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
      final type = property['type'] as String?;
      final skipEquality = property['ignore_equality'] == true;
      final defaultValue = property['default_value']?.toString();
      final disallowNull = property.containsKey('disallow_null')
          ? (property['disallow_null'] == true)
          : disallowNullForDefaults;
      ItemType itemType;

      if (type == null) {
        throw Exception('$name has no defined type');
      }
      final lowerType = type.toLowerCase();
      if (lowerType == 'object' ||
          lowerType == 'dynamic' ||
          lowerType == 'any') {
        itemType = DynamicType();
      } else if (type == 'bool' || lowerType == 'boolean') {
        itemType = BooleanType();
      } else if (lowerType == 'string') {
        itemType = StringType();
      } else if (lowerType == 'date' || lowerType == 'datetime') {
        itemType = DateTimeType();
      } else if (lowerType == 'double') {
        itemType = DoubleType();
      } else if (type == 'int' || type == 'integer') {
        itemType = IntegerType();
      } else if (lowerType == 'array') {
        final items = property['items'];
        final arrayType = items['type'];
        itemType = ArrayType(_makeGenericName(arrayType));
      } else if (lowerType == 'map') {
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
        ignoreEquality: skipEquality,
        defaultValue: defaultValue,
        disallowNull: disallowNull,
      );
    } catch (e) {
      print('Something went wrong with $name:\n\n${e.toString()}');
      rethrow;
    }
  }

  Field getSimpleField({required String name, required String value}) {
    final optional = value.endsWith('?');
    final typeString = optional ? value.substring(0, value.length - 1) : value;

    final type = _parseSimpleType(typeString);

    return Field(
      name: name,
      type: type,
      isRequired: !optional,
      ignore: false,
      includeIfNull: true,
      nonFinal: false,
      ignoreEquality: false,
    );
  }

  String _makeGenericName(String typeName) {
    final lowerType = typeName.toLowerCase();
    if (lowerType == 'string') {
      return 'String';
    } else if (lowerType == 'bool' || lowerType == 'boolean') {
      return 'bool';
    } else if (lowerType == 'double') {
      return 'double';
    } else if (lowerType == 'date' || lowerType == 'datetime') {
      return 'DateTime';
    } else if (lowerType == 'int' || lowerType == 'integer') {
      return 'int';
    } else if (lowerType == 'object' ||
        lowerType == 'dynamic' ||
        lowerType == 'any') {
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
      for (final element in dartType.generics) {
        paths.addAll(getPathsForName(pubspecConfig, element.toString()));
      }
      return paths;
    } else {
      final baseDirectory =
          foundModel.baseDirectory ?? pubspecConfig.baseDirectory;
      final path = foundModel.path;
      if (path == null) {
        return [baseDirectory];
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
    final extendsModels = <String>{};
    for (final model in models) {
      names.add(model.name);
      if (model.extendsModel != null) {
        extendsModels.add(model.extendsModel!);
      }
      if (model is ObjectModel) {
        for (final field in model.fields) {
          final type = field.type;
          types.add(type.name);
          if (type is MapType) {
            types.add(type.valueName);
          }
        }
      }
    }

    print('Registered models:');
    print(names);
    print('=======');
    print('Models used as a field in another model:');
    print(types);
    if (extendsModels.isNotEmpty) {
      print('=======');
      print('Models being extended:');
      print(extendsModels);
    }
    for (final type in types) {
      DartType(type).checkTypesKnown(names);
    }
    for (final extendsType in extendsModels) {
      checkTypesKnown(names, extendsType);
    }
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

  void checkTypesKnown(final Set<String> names, String type) {
    if (!TypeChecker.isKnownDartType(type) && !names.contains(type)) {
      throw Exception(
          'Could not generate all models. `$type` is not added to the config file, but is extended. These types are known: ${names.join(',')}');
    }
  }

  ItemType _parseSimpleType(String type) {
    final listRegex = RegExp(r'^\s*[Ll]ist<\s*([a-zA-Z_0-9]*)\s*>\s*$');
    final mapRegex =
        RegExp(r'^\s*[Mm]ap<([a-zA-Z_0-9]*)\s*,\s*([a-zA-Z_0-9]*)\s*>\s*$');

    final lowerType = type.toLowerCase();

    if (lowerType == 'object' || lowerType == 'dynamic' || lowerType == 'any') {
      return DynamicType();
    } else if (lowerType == 'bool' || lowerType == 'boolean') {
      return BooleanType();
    } else if (lowerType == 'string') {
      return StringType();
    } else if (lowerType == 'date' || lowerType == 'datetime') {
      return DateTimeType();
    } else if (lowerType == 'double') {
      return DoubleType();
    } else if (lowerType == 'int' || lowerType == 'integer') {
      return IntegerType();
    } else if (listRegex.hasMatch(type)) {
      final arrayType = listRegex.firstMatch(type)!.group(1)!;
      return ArrayType(_makeGenericName(arrayType));
    } else if (mapRegex.hasMatch(type)) {
      final match = mapRegex.firstMatch(type)!;
      return MapType(
          key: _makeGenericName(match.group(1)!),
          valueName: _makeGenericName(match.group(2)!));
    }
    return ObjectType(type);
  }
}
