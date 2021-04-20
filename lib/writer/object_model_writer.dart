import 'package:model_generator/model/item_type/map_type.dart';

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
    (jsonModel.extraImports ?? pubspecConfig.extraImports)
        .forEach((element) => imports.add('import \'$element\';'));

    jsonModel.fields.forEach((field) {
      final type = field.type;
      if (!TypeChecker.isKnownDartType(type.name)) {
        imports.add(_getImportFromPath(type.name));
      }
      if (type is MapType && !TypeChecker.isKnownDartType(type.valueName)) {
        imports.add(_getImportFromPath(type.valueName));
      }
    });
    jsonModel.converters.forEach((converter) {
      imports.add(_getImportFromPath(converter));
    });
    imports.forEach(sb.writeln);

    sb
      ..writeln()
      ..writeln("part '${jsonModel.fileName}.g.dart';")
      ..writeln()
      ..writeln('@JsonSerializable()');
    (jsonModel.extraAnnotations ?? pubspecConfig.extraAnnotations)
        .forEach(sb.writeln);

    jsonModel.converters.forEach((converter) {
      sb.writeln('@$converter()');
    });

    sb.writeln('class ${jsonModel.name} {');

    jsonModel.fields.sort((a, b) {
      final b1 = a.isRequired ? 1 : 0;
      final b2 = b.isRequired ? 1 : 0;
      return b2 - b1;
    });

    jsonModel.fields.forEach((key) {
      sb.write("  @JsonKey(name: '${key.serializedName}'");
      if (key.isRequired) {
        sb.write(', required: true');
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
      if (fieldModel is CustomFromToJsonModel) {
        sb.write(', fromJson: handle${fieldModel.name}FromJson');
      }
      if (fieldModel is CustomFromToJsonModel) {
        sb.write(', toJson: handle${fieldModel.name}ToJson');
      }
      sb.writeln(')');
      if (key.nonFinal) {
        sb.write('  ');
      } else {
        sb.write('  final ');
      }
      final nullableFlag = key.isRequired ? '' : '?';
      final keyType = key.type;
      if (keyType is ArrayType) {
        sb.writeln('List<${keyType.name}>$nullableFlag ${key.name};');
      } else if (keyType is MapType) {
        sb.writeln(
            'Map<${keyType.name}, ${keyType.valueName}>$nullableFlag ${key.name};');
      } else {
        sb.writeln('${key.type.name}$nullableFlag ${key.name};');
      }
    });

    final anyNonFinal = jsonModel.fields.any((element) => element.nonFinal);
    sb
      ..writeln()
      ..writeln('  ${anyNonFinal ? '' : 'const '}${jsonModel.name}({');

    jsonModel.fields.forEach((key) {
      if (key.isRequired) {
        sb.writeln('    required this.${key.name},');
      } else {
        sb.writeln('    this.${key.name},');
      }
    });
    sb..writeln('  });')..writeln();
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

    if (jsonModel.equalsAndHashCode ?? pubspecConfig.equalsHashCode) {
      sb
        ..writeln()
        ..writeln('  @override')
        ..writeln('  bool operator ==(Object other) =>')
        ..writeln('      identical(this, other) ||')
        ..writeln('      other is ${jsonModel.name} &&')
        ..write('          runtimeType == other.runtimeType');
      jsonModel.fields.forEach((field) {
        sb.write(' &&\n          ${field.name} == other.${field.name}');
      });
      sb
        ..writeln(';')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  int get hashCode =>');
      var c = 0;
      jsonModel.fields.forEach((field) {
        if (c++ > 0) sb.write(' ^\n');
        sb.write('      ${field.name}.hashCode');
      });
      sb.writeln(';');
    }
    if (pubspecConfig.generateToString) {
      sb
      ..writeln()
      ..writeln('  @override')
      ..writeln('  String toString() =>')
      ..writeln('      \'${jsonModel.name}{\'');

      var c = 0;
      jsonModel.fields.forEach((field) {
        if (c++ > 0) sb.writeln(', \'');
        sb.write('      \'${field.name}: \$${field.name}');
      });
      sb.writeln('\'\n      \'}\';');
    }

    sb..writeln()..writeln('}');
    return sb.toString();
  }

  String _getImportFromPath(String name) {
    final projectName = pubspecConfig.projectName;
    final reCaseFieldName = CaseUtil(name);
    final path = yamlConfig.getPathForName(pubspecConfig, name);
    String pathWithPackage;
    if (path.startsWith('package:')) {
      pathWithPackage = path;
    } else {
      pathWithPackage = 'package:$projectName/$path';
    }

    if (path.endsWith('.dart')) {
      return "import '$pathWithPackage';";
    } else {
      return "import '$pathWithPackage/${reCaseFieldName.snakeCase}.dart';";
    }
  }
}
