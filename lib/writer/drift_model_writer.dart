import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/case_util.dart';
import 'package:model_generator/util/generic_type.dart';
import 'package:model_generator/util/type_checker.dart';
import 'package:path/path.dart';

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
    final modelDirectory = [
      pubspecConfig.projectName,
      jsonModel.baseDirectory,
      jsonModel.path,
      '${jsonModel.fileName}.dart'
    ].whereType<String>();
    final imports = <String>{}
      ..add("import 'package:drift/drift.dart';")
      ..add(
          "import 'package:${pubspecConfig.projectName}/${pubspecConfig.databasePath}';")
      ..add("import 'package:${joinAll(modelDirectory)}';");

    for (final element in (jsonModel.extraImports ?? [])) {
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
      if (!TypeChecker.isKnownDartType(type.name) &&
          type.name != jsonModel.name) {
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

    for (final field in jsonModel.fields.where((element) =>
        !element.ignoreForTable &&
        (element.type is ArrayType || element.type is MapType))) {
      print(
          '[WARNING] ${field.name} is an array or map. This is not supported in tables atm and will be ignored.');
      field.ignoreForTable = true;
    }

    final fields =
        jsonModel.fields.where((element) => !element.ignoreForTable).toList();

    fields.sort((a, b) {
      final b1 = a.isRequired ? 1 : 0;
      final b2 = b.isRequired ? 1 : 0;
      return b2 - b1;
    }); // same order as object model writer

    if (fields.any((element) => element.isTablePrimaryKey)) {
      sb
        ..writeln('  @override')
        ..writeln(
            '  Set<Column> get primaryKey => {${fields.where((element) => element.isTablePrimaryKey).map((e) => e.name).join(', ')}};')
        ..writeln('');
    }

    for (final field in fields) {
      final description = field.description;
      if (description != null) {
        sb.writeln('  ///$description');
      }
      if (field.isEnum) {
        sb.write(
            "  TextColumn get ${field.name} => text().map(const ${modelNameUpperCamelCase}Table${CaseUtil(field.type.name).upperCamelCase}Converter())");
      } else {
        if (field.type.driftColumn == null || field.type.driftType == null) {
          throw Exception(
              'No drift column or type for ${field.type.name} (${field.name})');
        }
        sb.write(
            "  ${field.type.driftColumn} get ${field.name} => ${field.type.driftType}()");
      }

      if (!field.isRequired && !field.disallowNull) {
        sb.write('.nullable()');
      }
      if (field.tableAutoIncrement) {
        if (field.type is! IntegerType) {
          print(
              '[WARNING] autoIncrement is only supported for integer types, but ${field.name} is ${field.type.name}. This may cause issues.');
        }
        sb.write('.autoIncrement()');
      }

      sb
        ..writeln('();')
        ..writeln('');
    }

    sb
      ..writeln('}')
      ..writeln('')
      ..writeln(
          'extension Db${modelNameUpperCamelCase}Extension on Db$modelNameUpperCamelCase {');

    if (jsonModel.fields.any((element) => element.ignoreForTable)) {
      final ignoredFields =
          jsonModel.fields.where((element) => element.ignoreForTable).toList();
      final ignoredFieldsString = ignoredFields
          .map((e) =>
              '${e.isRequired ? 'required ' : ''}${_getKeyType(e)} ${e.name}')
          .join(', ');
      sb.writeln(
          '  ${jsonModel.name} getModel({$ignoredFieldsString}) => ${jsonModel.name}(');
    } else {
      sb.writeln('  ${jsonModel.name} get model => ${jsonModel.name}(');
    }

    for (final field in jsonModel.fields) {
      sb.writeln('        ${field.name}: ${field.name},');
    }

    sb
      ..writeln('      );')
      ..writeln('}')
      ..writeln('')
      ..writeln(
          'extension ${modelNameUpperCamelCase}Extension on $modelNameUpperCamelCase {')
      ..writeln(
          '  Db$modelNameUpperCamelCase get dbModel => Db$modelNameUpperCamelCase(');

    for (final field in fields) {
      sb.writeln('        ${field.name}: ${field.name},');
    }

    sb
      ..writeln('      );')
      ..writeln('}');

    for (final enumType
        in fields.where((e) => e.isEnum).map((e) => e.type.name).toSet()) {
      final uppercaseFieldName = CaseUtil(enumType).upperCamelCase;
      sb
        ..writeln()
        ..writeln(
            """class ${modelNameUpperCamelCase}Table${uppercaseFieldName}Converter extends TypeConverter<$uppercaseFieldName, String> {
  const ${modelNameUpperCamelCase}Table${uppercaseFieldName}Converter();

  @override
  $uppercaseFieldName fromSql(String fromDb) {
    for (final value in $uppercaseFieldName.values) {
      if (value.toString() == fromDb) return value;
    }
    return $uppercaseFieldName.values.first;
  }

  @override
  String toSql($uppercaseFieldName value) {
    return value.toString();
  }
}""");
    }

    return sb.toString();
  }

  String _getKeyType(Field field) {
    final nullableFlag =
        field.isRequired || field.type.name == 'dynamic' ? '' : '?';
    final keyType = field.type;
    if (keyType is ArrayType) {
      return 'List<${keyType.name}>$nullableFlag';
    } else if (keyType is MapType) {
      return 'Map<${keyType.name}, ${keyType.valueName}>$nullableFlag';
    } else {
      return '${keyType.name}$nullableFlag';
    }
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
          imports.add(
              "import '$pathWithPackage/${reCaseFieldName.snakeCase}.dart';");
        }
      }
    }
    return imports.toList()..sort((i1, i2) => i1.compareTo(i2));
  }
}
