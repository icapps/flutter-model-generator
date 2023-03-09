import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/model/model/field_name_with_nullable.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/case_util.dart';
import 'package:model_generator/util/field_util.dart';
import 'package:model_generator/util/model_helper.dart';
import 'package:path/path.dart';

class DriftModelWriter {
  final PubspecConfig pubspecConfig;
  final ObjectModel jsonModel;
  final YmlGeneratorConfig ymlConfig;

  const DriftModelWriter(
    this.pubspecConfig,
    this.jsonModel,
    this.ymlConfig,
  );

  String write() {
    final extendsFields = FieldUtil.getExtendedFields(jsonModel, ymlConfig);
    final enumFields = FieldUtil.getEnumFields(jsonModel, ymlConfig);

    final sb = StringBuffer();
    final modelDirectory = [pubspecConfig.projectName, jsonModel.baseDirectory, jsonModel.path, '${jsonModel.fileName}.dart'].whereType<String>();

    ModelHelper.writeImports(
      initialImports: {
        "import 'package:drift/drift.dart';",
        "import 'package:${pubspecConfig.projectName}/${pubspecConfig.databasePath}';",
        "import 'package:${joinAll(modelDirectory)}';",
      },
      jsonModel: jsonModel,
      pubspecConfig: pubspecConfig,
      ymlConfig: ymlConfig,
      extendsFields: extendsFields,
      sb: sb,
      isForTable: true,
    );

    final modelNameUpperCamelCase = CaseUtil(jsonModel.name).upperCamelCase;

    sb.writeln('@DataClassName(\'Db$modelNameUpperCamelCase\')');
    final modelDescription = jsonModel.description?.trim();
    if (modelDescription != null && modelDescription.isNotEmpty) {
      sb.writeln("///$modelDescription");
    }
    sb.writeln('class Db${modelNameUpperCamelCase}Table extends Table {');

    for (final field in jsonModel.fields.where((element) => !element.ignoreForTable && element.type is MapType && element.typeConverterForTable == null)) {
      throw Exception(
          '${field.name} is a map which is not a supported column. You should create a separate table for this and ignore the field. You can ignore this field by adding ignore_for_table: true');
    }

    final fields = jsonModel.fields.where((element) => !element.ignoreForTable).toList();

    fields.sort((a, b) {
      final b1 = a.isRequired ? 1 : 0;
      final b2 = b.isRequired ? 1 : 0;
      return b2 - b1;
    }); // same order as object model writer

    if (fields.any((element) => element.isTablePrimaryKey)) {
      sb
        ..writeln('  @override')
        ..writeln('  Set<Column> get primaryKey => {${fields.where((element) => element.isTablePrimaryKey).map((e) => e.name).join(', ')}};')
        ..writeln('');
    } else if (!fields.any((element) => element.tableAutoIncrement)) {
      print('WARNING: No primary key or auto increment found for ${jsonModel.name}.');
    }

    final otherTablesToCreate = <Field, ObjectModel>{};
    final fieldsFromOtherTables = <Field>[];
    final primaryKeys = <ItemType, List<Field>>{};
    for (final entry in fields.asMap().entries) {
      final field = entry.value;
      final description = field.description;
      if (description != null) {
        sb.writeln('  ///$description');
      }
      if (field.typeConverterForTable != null) {
        sb.write("  TextColumn get ${field.name} => text().map(const ${field.typeConverterForTable}())");
      } else if (enumFields.contains(field)) {
        sb.write(
            "  TextColumn get ${field.name} => text().map(const ${modelNameUpperCamelCase}Table${CaseUtil(field.type.name).upperCamelCase}${field.isRequired ? '' : 'Nullable'}Converter())");
      } else {
        if (field.type is ArrayType) {
          final model = FieldUtil.getModelByType(field.type, ymlConfig);
          print('arrayType: ${field.type.name} (${field.name}) model: $model');
          if (model != null) otherTablesToCreate.addAll({field: model});
          continue;
        } else if (field.type is MapType) {
          throw Exception('We are not able to handle maps at this time. Unable to create column for ${field.type.name} (${field.name})');
        } else if (field.type.driftColumn == null || field.type.driftType == null) {
          fieldsFromOtherTables.add(field);
          primaryKeys[field.type] ??= FieldUtil.getPrimaryKeys(field.type, ymlConfig);
          for (final primaryKeyField in primaryKeys[field.type]!) {
            sb.write("  ${primaryKeyField.type.driftColumn} get ${field.name}${CaseUtil(primaryKeyField.name).upperCamelCase} => ${primaryKeyField.type.driftType}()");
            if ((!field.isRequired && !field.disallowNull) || (!primaryKeyField.isRequired && !primaryKeyField.disallowNull)) {
              sb.write('.nullable()');
            }
            sb.writeln('();');
            sb.writeln('');
          }
          continue;
        } else {
          sb.write("  ${field.type.driftColumn} get ${field.name} => ${field.type.driftType}()");
        }
      }

      if (field.tableAutoIncrement) {
        if (field.type is! IntegerType) {
          throw Exception('autoIncrement is only supported for integer types, but ${field.name} is ${field.type.name}.');
        }
        sb.write('.autoIncrement()');
      } else if (!field.isRequired && !field.disallowNull) {
        sb.write('.nullable()');
      }

      sb.writeln('();');
      if (entry.key != fields.length - 1) {
        sb.writeln('');
      }
    }

    sb
      ..writeln('}')
      ..writeln('');

    for (final entry in otherTablesToCreate.entries) {
      final field = entry.key;
      final table = entry.value;
      sb.writeln("@DataClassName('Db${jsonModel.name}${CaseUtil(field.name).upperCamelCase}')");
      sb.writeln('class Db${jsonModel.name}${CaseUtil(field.name).upperCamelCase}Table extends Table {');
      for (final primaryKeyField in jsonModel.fields.where((element) => element.isTablePrimaryKey)) {
        sb.write("  ${primaryKeyField.type.driftColumn} get ${primaryKeyField.name} => ${primaryKeyField.type.driftType}()");
        if (!primaryKeyField.isRequired && !primaryKeyField.disallowNull) {
          sb.write('.nullable()');
        }
        sb.writeln('();');
        sb.writeln('');
      }
      for (final primaryKeyField in table.fields.where((element) => element.isTablePrimaryKey)) {
        sb.write("  ${primaryKeyField.type.driftColumn} get ${field.name}${CaseUtil(primaryKeyField.name).upperCamelCase} => ${primaryKeyField.type.driftType}()");
        if (!primaryKeyField.isRequired && !primaryKeyField.disallowNull) {
          sb.write('.nullable()');
        }
        sb.writeln('();');
        sb.writeln('');
      }
      sb.writeln('}');
      sb.writeln('');
    }

    sb.writeln('extension Db${modelNameUpperCamelCase}Extension on Db$modelNameUpperCamelCase {');

    final fieldsNotInTable = FieldUtil.getFieldsNotInTable(jsonModel, sorted: true, additionalFields: fieldsFromOtherTables..addAll(otherTablesToCreate.keys));
    if (fieldsNotInTable.isNotEmpty) {
      var fieldsNotInTableString =
          fieldsNotInTable.map((e) => '${e.isRequired ? 'required ' : ''}${ModelHelper.getKeyType(e)} ${e.name}').join(',${fieldsNotInTable.length > 1 ? '\n    ' : ' '}');
      if (fieldsNotInTable.length > 1) fieldsNotInTableString = '\n    $fieldsNotInTableString,\n  ';
      sb.writeln('  ${jsonModel.name} getModel({$fieldsNotInTableString}) => ${jsonModel.name}(');
    } else {
      sb.writeln('  ${jsonModel.name} get model => ${jsonModel.name}(');
    }

    for (final field in jsonModel.fields.where((element) => !element.onlyForTable)) {
      sb.writeln('        ${field.name}: ${field.name},');
    }

    sb
      ..writeln('      );')
      ..writeln('}')
      ..writeln('')
      ..writeln('extension ${modelNameUpperCamelCase}Extension on $modelNameUpperCamelCase {');

    if (jsonModel.fields.any((element) => element.onlyForTable && !element.ignoreForTable)) {
      final fieldsOnlyForTable = jsonModel.fields.where((element) => element.onlyForTable && !element.ignoreForTable).toList()
        ..sort((a, b) => (a.isRequired == b.isRequired ? 0 : (a.isRequired ? -1 : 1)));
      var fieldsOnlyForTableString =
          fieldsOnlyForTable.map((e) => '${e.isRequired ? 'required ' : ''}${ModelHelper.getKeyType(e)} ${e.name}').join(',${fieldsOnlyForTable.length > 1 ? '\n    ' : ' '}');
      if (fieldsOnlyForTable.length > 1) fieldsOnlyForTableString = '\n    $fieldsOnlyForTableString,\n  ';
      sb.writeln('  Db$modelNameUpperCamelCase getDbModel({$fieldsOnlyForTableString}) => Db$modelNameUpperCamelCase(');
    } else {
      sb.writeln('  Db$modelNameUpperCamelCase get dbModel => Db$modelNameUpperCamelCase(');
    }

    for (final field in fields.where((element) => !element.ignoreForTable)) {
      if (otherTablesToCreate.containsKey(field)) {
        continue;
      } else if (fieldsFromOtherTables.contains(field)) {
        for (final primaryKey in primaryKeys[field.type]!) {
          sb.writeln('        ${field.name}${CaseUtil(primaryKey.name).upperCamelCase}: ${field.name}${!field.isRequired && !field.disallowNull ? '?' : ''}.${primaryKey.name},');
        }
      } else {
        sb.writeln('        ${field.name}: ${field.name},');
      }
    }

    sb
      ..writeln('      );')
      ..writeln('}');

    final generateConverterForFields = enumFields.where((element) => !element.ignoreForTable && element.typeConverterForTable == null).toList();
    final generateConverterForFieldsWithNullable = generateConverterForFields.map((value) => FieldNameWithNullable(value.type.name, !value.isRequired)).toSet();

    for (final enumField in generateConverterForFieldsWithNullable) {
      final enumType = enumField.name;
      final nullableText = enumField.isNullable ? 'Nullable' : '';
      final nullableQuestionMark = enumField.isNullable ? '?' : '';
      final uppercaseFieldName = CaseUtil(enumType).upperCamelCase;
      sb
        ..writeln()
        ..writeln(
            """class ${modelNameUpperCamelCase}Table$uppercaseFieldName${nullableText}Converter extends TypeConverter<$uppercaseFieldName$nullableQuestionMark, String$nullableQuestionMark> {
  const ${modelNameUpperCamelCase}Table$uppercaseFieldName${nullableText}Converter();

  @override
  $uppercaseFieldName$nullableQuestionMark fromSql(String$nullableQuestionMark fromDb) {
    for (final value in $uppercaseFieldName.values) {
      if (value.jsonValue == fromDb) return value;
    }
    return ${enumField.isNullable ? 'null' : '$uppercaseFieldName.values.first'};
  }

  @override
  String$nullableQuestionMark toSql($uppercaseFieldName$nullableQuestionMark value) {
    return value$nullableQuestionMark.jsonValue;
  }
}""");
    }

    return sb.toString();
  }
}
