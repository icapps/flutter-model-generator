import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/util/generic_type.dart';

import '../config/pubspec_config.dart';
import '../config/yml_generator_config.dart';
import '../model/model/object_model.dart';
import '../util/case_util.dart';
import '../util/type_checker.dart';

class DriftModelWriter {
  final PubspecConfig pubspecConfig;
  final ObjectModel jsonModel;
  final List<Field> extendsFields;
  final YmlGeneratorConfig yamlConfig;

  const DriftModelWriter(
    this.pubspecConfig,
    this.jsonModel,
    this.extendsFields,
    this.yamlConfig,
  );

  String write() {
    final sb = StringBuffer();
    final imports = <String>{}
      ..add("import 'package:drift/drift.dart';")
      ..add("import 'package:${pubspecConfig.projectName}/${pubspecConfig.databasePath}';");

    for (final element in (jsonModel.extraImports ?? pubspecConfig.extraImports)) {
      imports.add('import \'$element\';');
    }
    final extendsModel = jsonModel.extendsModel;

    if (extendsModel != null) {
      if (!TypeChecker.isKnownDartType(extendsModel)) {
        imports.addAll(_getImportsFromPath(extendsModel));
      }
    }

    for (final field in jsonModel.fields) {
      final type = field.type;
      if (!TypeChecker.isKnownDartType(type.name) && type.name != jsonModel.name) {
        imports.addAll(_getImportsFromPath(type.name));
      }
      if (type is MapType && !TypeChecker.isKnownDartType(type.valueName)) {
        imports.addAll(_getImportsFromPath(type.valueName));
      }
    }
    for (final field in extendsFields) {
      imports.addAll(_getImportsFromField(field));
    }

    for (final converter in jsonModel.converters) {
      imports.addAll(_getImportsFromPath(converter));
    }
    (imports.toList()..sort((i1, i2) => i1.compareTo(i2))).forEach(sb.writeln);

    sb.writeln();

    final modelNameUpperCamelCase = CaseUtil(jsonModel.name).upperCamelCase;

    sb.writeln('@DataClassName(\'Db$modelNameUpperCamelCase\')');
    final modelDescription = jsonModel.description?.trim();
    if (modelDescription != null && modelDescription.isNotEmpty) {
      sb.writeln("///$modelDescription");
    }
    sb.writeln('class Db${modelNameUpperCamelCase}Table extends Table {');

    jsonModel.fields.sort((a, b) {
      final b1 = a.isRequired ? 1 : 0;
      final b2 = b.isRequired ? 1 : 0;
      return b2 - b1;
    }); // same order as object model writer

    for (final key in jsonModel.fields) {
      final description = key.description;
      if (description != null) {
        sb.writeln('  ///$description');
      }
      if (key.type.driftColumn == null || key.type.driftType == null) {
        throw Exception('No drift column or type for ${key.type.name} (${key.name})');
      }

      sb.write("  ${key.type.driftColumn} get ${key.name} => ${key.type.driftType}()");

      if (!key.isRequired && !key.disallowNull) {
        sb.write('.nullable()');
      }

      sb
        ..writeln('();')
        ..writeln('');
    }

    sb
      ..writeln('}')
      ..writeln('')
      ..writeln('extension Db${modelNameUpperCamelCase}Extension on Db$modelNameUpperCamelCase {')
      ..writeln('  ${jsonModel.name} get model => ${jsonModel.name}(');

    for (final key in jsonModel.fields) {
      sb.writeln('        ${key.name}: ${key.name},');
    }

    sb
      ..writeln('      );')
      ..writeln('}')
      ..writeln('')
      ..writeln('extension ${modelNameUpperCamelCase}Extension on $modelNameUpperCamelCase {')
      ..writeln('  Db$modelNameUpperCamelCase get dbModel => Db$modelNameUpperCamelCase(');

    for (final key in jsonModel.fields) {
      sb.writeln('        ${key.name}: ${key.name},');
    }

    sb
      ..writeln('      );')
      ..writeln('}');

    return sb.toString();
  }

  Iterable<String> _getImportsFromField(Field field) {
    final imports = <String>{};
    final type = field.type;
    if (!TypeChecker.isKnownDartType(type.name)) {
      imports.addAll(_getImportsFromPath(type.name));
    }
    if (type is MapType && !TypeChecker.isKnownDartType(type.valueName)) {
      imports.addAll(_getImportsFromPath(type.valueName));
    }
    return imports;
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
          imports.add("import '$pathWithPackage/${reCaseFieldName.snakeCase}.dart';");
        }
      }
    }
    return imports.toList()..sort((i1, i2) => i1.compareTo(i2));
  }
}