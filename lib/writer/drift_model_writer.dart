import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/case_util.dart';
import 'package:model_generator/util/field_util.dart';
import 'package:model_generator/util/model_helper.dart';
import 'package:path/path.dart';

class DriftModelWriter {
  final PubspecConfig pubspecConfig;
  final ObjectModel jsonModel;
  final YmlGeneratorConfig yamlConfig;

  const DriftModelWriter(
    this.pubspecConfig,
    this.jsonModel,
    this.yamlConfig,
  );

  String write() {
    final extendsFields = FieldUtil.getExtendedFields(jsonModel, yamlConfig);
    final enumFields = FieldUtil.getEnumFields(jsonModel, yamlConfig);

    final sb = StringBuffer();
    final modelDirectory = [
      pubspecConfig.projectName,
      jsonModel.baseDirectory,
      jsonModel.path,
      '${jsonModel.fileName}.dart'
    ].whereType<String>();

    ModelHelper.writeImports(
      initialImports: {
        "import 'package:drift/drift.dart';",
        "import 'package:${pubspecConfig.projectName}/${pubspecConfig.databasePath}';",
        "import 'package:${joinAll(modelDirectory)}';",
      },
      jsonModel: jsonModel,
      pubspecConfig: pubspecConfig,
      yamlConfig: yamlConfig,
      extendsFields: extendsFields,
      sb: sb,
    );

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
      throw Exception(
          '${field.name} is an array or map. Ignore this field by adding ignore_for_table: true');
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
      if (enumFields.contains(field)) {
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

      if (field.tableAutoIncrement) {
        if (field.type is! IntegerType) {
          throw Exception(
              'autoIncrement is only supported for integer types, but ${field.name} is ${field.type.name}.');
        }
        sb.write('.autoIncrement()');
      } else if (!field.isRequired && !field.disallowNull) {
        sb.write('.nullable()');
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
              '${e.isRequired ? 'required ' : ''}${ModelHelper.getKeyType(e)} ${e.name}')
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

    for (final enumType in enumFields
        .where((element) => !element.ignoreForTable)
        .map((e) => e.type.name)
        .toSet()) {
      final uppercaseFieldName = CaseUtil(enumType).upperCamelCase;
      sb
        ..writeln()
        ..writeln(
            """class ${modelNameUpperCamelCase}Table${uppercaseFieldName}Converter extends TypeConverter<$uppercaseFieldName, String> {
  const ${modelNameUpperCamelCase}Table${uppercaseFieldName}Converter();

  @override
  $uppercaseFieldName fromSql(String fromDb) {
    for (final value in $uppercaseFieldName.values) {
      if (value.jsonValue == fromDb) return value;
    }
    return $uppercaseFieldName.values.first;
  }

  @override
  String toSql($uppercaseFieldName value) {
    return value.jsonValue;
  }
}""");
    }

    return sb.toString();
  }
}
