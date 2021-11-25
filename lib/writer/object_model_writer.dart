import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/util/generic_type.dart';

import '../config/pubspec_config.dart';
import '../config/yml_generator_config.dart';
import '../model/item_type/array_type.dart';
import '../model/model/custom_from_to_json_model.dart';
import '../model/model/object_model.dart';
import '../util/case_util.dart';
import '../util/type_checker.dart';

class ObjectModelWriter {
  final PubspecConfig pubspecConfig;
  final ObjectModel jsonModel;
  final YmlGeneratorConfig yamlConfig;

  const ObjectModelWriter(this.pubspecConfig, this.jsonModel, this.yamlConfig);

  String write() {
    final sb = StringBuffer();
    final imports = <String>{}
      ..add("import 'package:json_annotation/json_annotation.dart';");
    for (var element
        in (jsonModel.extraImports ?? pubspecConfig.extraImports)) {
      imports.add('import \'$element\';');
    }

    for (var field in jsonModel.fields) {
      final type = field.type;
      if (!TypeChecker.isKnownDartType(type.name) &&
          type.name != jsonModel.name) {
        imports.addAll(_getImportsFromPath(type.name));
      }
      if (type is MapType && !TypeChecker.isKnownDartType(type.valueName)) {
        imports.addAll(_getImportsFromPath(type.valueName));
      }
    }
    for (var converter in jsonModel.converters) {
      imports.addAll(_getImportsFromPath(converter));
    }
    (imports.toList()..sort((i1, i2) => i1.compareTo(i2))).forEach(sb.writeln);

    sb
      ..writeln()
      ..writeln("part '${jsonModel.fileName}.g.dart';")
      ..writeln();

    final modelDescription = jsonModel.description?.trim();
    if (modelDescription != null && modelDescription.isNotEmpty) {
      sb.writeln("///$modelDescription");
    }

    if (jsonModel.explicitToJson ?? pubspecConfig.explicitToJson) {
      sb.writeln('@JsonSerializable(explicitToJson: true)');
    } else {
      sb.writeln('@JsonSerializable()');
    }
    (jsonModel.extraAnnotations ?? pubspecConfig.extraAnnotations)
        .forEach(sb.writeln);

    for (var converter in jsonModel.converters) {
      sb.writeln('@$converter()');
    }

    sb.writeln('class ${jsonModel.name} {');

    jsonModel.fields.sort((a, b) {
      final b1 = a.isRequired ? 1 : 0;
      final b2 = b.isRequired ? 1 : 0;
      return b2 - b1;
    });

    for (var key in jsonModel.fields) {
      final description = key.description;
      if (description != null) {
        sb.writeln('  ///$description');
      }
      sb.write("  @JsonKey(name: '${key.serializedName}'");
      if (key.isRequired) {
        if (key.hasDefaultValue) {
          sb.write(', required: false, disallowNullValue: true');
        } else {
          sb.write(', required: true');
        }
      }

      if (!key.includeIfNull) {
        sb.write(', includeIfNull: false');
      }

      if (key.ignore) {
        sb.write(', ignore: true');
      }

      if (key.unknownEnumValue != null) {
        sb.write(
            ', unknownEnumValue: ${key.type.name}.${key.unknownEnumValue}');
      }

      final fieldModel = yamlConfig.getModelByName(key.type);
      if (key.fromJson != null) {
        sb.write(', fromJson: ${key.fromJson}');
      } else if (fieldModel is CustomFromToJsonModel) {
        sb.write(', fromJson: handle${fieldModel.name}FromJson');
      }
      if (key.toJson != null) {
        sb.write(', toJson: ${key.toJson}');
      } else if (fieldModel is CustomFromToJsonModel) {
        sb.write(', toJson: handle${fieldModel.name}ToJson');
      }
      sb.writeln(')');
      if (key.nonFinal) {
        sb.write('  ');
      } else {
        sb.write('  final ');
      }
      final keyType = key.type;
      final nullableFlag =
          (key.isRequired || keyType.name == 'dynamic') ? '' : '?';
      if (keyType is ArrayType) {
        sb.writeln('List<${keyType.name}>$nullableFlag ${key.name};');
      } else if (keyType is MapType) {
        sb.writeln(
            'Map<${keyType.name}, ${keyType.valueName}>$nullableFlag ${key.name};');
      } else {
        sb.writeln('${keyType.name}$nullableFlag ${key.name};');
      }
    }

    final anyNonFinal = jsonModel.fields.any((element) => element.nonFinal);
    sb
      ..writeln()
      ..writeln('  ${anyNonFinal ? '' : 'const '}${jsonModel.name}({');

    for (var key in jsonModel.fields) {
      if (key.isRequired && !key.hasDefaultValue) {
        sb.writeln('    required this.${key.name},');
      } else if (key.hasDefaultValue) {
        sb.writeln('    this.${key.name} = ${key.defaultValue},');
      } else {
        sb.writeln('    this.${key.name},');
      }
    }
    sb
      ..writeln('  });')
      ..writeln();
    if (jsonModel.generateForGenerics) {
      sb.writeln(
          '  factory ${jsonModel.name}.fromJson(Object? json) => _\$${jsonModel.name}FromJson(json as Map<String, dynamic>); // ignore: avoid_as');
    } else {
      sb.writeln(
          '  factory ${jsonModel.name}.fromJson(Map<String, dynamic> json) => _\$${jsonModel.name}FromJson(json);');
    }
    sb
      ..writeln()
      ..writeln(
          '  Map<String, dynamic> toJson() => _\$${jsonModel.name}ToJson(this);');

    if (jsonModel.staticCreate ?? pubspecConfig.staticCreate) {
      sb
        ..writeln()
        ..writeln('  // ignore: prefer_constructors_over_static_methods')
        ..writeln(
            '  static ${jsonModel.name} create(${jsonModel.generateForGenerics ? 'Object? json' : 'Map<String, dynamic> json'}) => ${jsonModel.name}.fromJson(json);');
    }

    if (jsonModel.equalsAndHashCode ?? pubspecConfig.equalsHashCode) {
      sb
        ..writeln()
        ..writeln('  @override')
        ..writeln('  bool operator ==(Object other) =>')
        ..writeln('      identical(this, other) ||')
        ..writeln('      other is ${jsonModel.name} &&')
        ..write('          runtimeType == other.runtimeType');
      for (final field in jsonModel.fields) {
        if (!field.ignoreEquality) {
          sb.write(' &&\n          ${field.name} == other.${field.name}');
        }
      }
      sb
        ..writeln(';')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  int get hashCode =>');
      var c = 0;
      for (final field in jsonModel.fields) {
        if (!field.ignoreEquality) {
          if (c++ > 0) sb.write(' ^\n');
          sb.write('      ${field.name}.hashCode');
        }
      }
      if (c == 0) sb.write('      0');
      sb.writeln(';');
    }
    if (jsonModel.generateToString ?? pubspecConfig.generateToString) {
      sb
        ..writeln()
        ..writeln('  @override')
        ..writeln('  String toString() =>')
        ..writeln('      \'${jsonModel.name}{\'');

      var c = 0;
      for (var field in jsonModel.fields) {
        if (c++ > 0) sb.writeln(', \'');
        sb.write('      \'${field.name}: \$${field.name}');
      }
      sb.writeln('\'\n      \'}\';');
    }

    sb
      ..writeln()
      ..writeln('}');

    if (pubspecConfig.retrofitMappers) {
      createRetrofitMappers(sb);
    }

    return sb.toString();
  }

  Iterable<String> _getImportsFromPath(String name) {
    final imports = <String>{};
    for (final leaf in DartType(name).leaves) {
      final projectName = pubspecConfig.projectName;
      final reCaseFieldName = CaseUtil(leaf);
      final paths = yamlConfig.getPathsForName(pubspecConfig, leaf);
      for (final path in paths) {
        String pathWithPackage;
        if (path.startsWith('package:')) {
          pathWithPackage = path;
        } else {
          pathWithPackage = 'package:$projectName/$path';
        }

        if (path.endsWith('.dart')) {
          imports.add("import '$pathWithPackage';");
        } else {
          imports.add(
              "import '$pathWithPackage/${reCaseFieldName.snakeCase}.dart';");
        }
      }
    }
    return imports.toList()..sort((i1, i2) => i1.compareTo(i2));
  }

  void createRetrofitMappers(StringBuffer sb) {
    sb
      ..writeln()
      ..writeln(
          '${jsonModel.name} deserialize${jsonModel.name}(Map<String, dynamic> json) => ${jsonModel.name}.fromJson(json);')
      ..writeln()
      ..writeln(
          'Map<String, dynamic> serialize${jsonModel.name}(${jsonModel.name} object) => object.toJson();')
      ..writeln()
      ..writeln(
          'List<${jsonModel.name}> deserialize${jsonModel.name}List(List<Map<String, dynamic>> jsonList)')
      ..writeln(
          '    => jsonList.map((json) => ${jsonModel.name}.fromJson(json)).toList();')
      ..writeln()
      ..writeln(
          'List<Map<String, dynamic>> serialize${jsonModel.name}List(List<${jsonModel.name}> objects)')
      ..writeln('    => objects.map((object) => object.toJson()).toList();');
  }
}
