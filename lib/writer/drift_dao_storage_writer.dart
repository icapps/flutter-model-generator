import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/case_util.dart';
import 'package:model_generator/util/field_util.dart';
import 'package:model_generator/util/model_helper.dart';
import 'package:path/path.dart';

class DriftDaoStorageWriter {
  final PubspecConfig pubspecConfig;
  final ObjectModel jsonModel;
  final YmlGeneratorConfig ymlConfig;

  const DriftDaoStorageWriter(
    this.pubspecConfig,
    this.jsonModel,
    this.ymlConfig,
  );

  String write() {
    final extendsFields = FieldUtil.getExtendedFields(jsonModel, ymlConfig);
    final enumFields = FieldUtil.getEnumFields(jsonModel, ymlConfig);

    final sb = StringBuffer();
    final modelDirectory = [pubspecConfig.projectName, jsonModel.baseDirectory, jsonModel.path, '${jsonModel.fileName}.dart'].whereType<String>();
    final tableDirectory = [pubspecConfig.projectName, 'database', 'tables', jsonModel.path, '${jsonModel.fileName}_table.dart'].whereType<String>();
    final additionalImports = <String>{};

    final primaryKeys = <ItemType, List<Field>>{};
    final fieldsFromOtherTables = jsonModel.fields.where((field) =>
        field.typeConverterForTable == null && !enumFields.contains(field) && field.type is! MapType && (field.type.driftColumn == null || field.type.driftType == null));

    final otherTables = <String>{};
    for (final field in fieldsFromOtherTables) {
      primaryKeys[field.type] = FieldUtil.getPrimaryKeys(field.type, ymlConfig);
      final fieldModel = FieldUtil.getModelByType(field.type, ymlConfig);
      if (fieldModel == null) continue;
      final String tableName;
      if (field.type is ArrayType) {
        tableName = '${jsonModel.name}${CaseUtil(field.name).upperCamelCase}';
        final typeDirectory = [pubspecConfig.projectName, fieldModel.baseDirectory, fieldModel.path, '${fieldModel.fileName}.dart'].whereType<String>();
        additionalImports.add("import 'package:${joinAll(typeDirectory)}';");
      } else {
        tableName = fieldModel.name;
      }
      otherTables.add(tableName);
      final otherTableFile = [pubspecConfig.projectName, 'database', 'tables', fieldModel.path, '${fieldModel.fileName}_table.dart'].whereType<String>();
      additionalImports.add("import 'package:${joinAll(otherTableFile)}';");
    }

    ModelHelper.writeImports(
      initialImports: {
        "import 'package:drift/drift.dart';",
        "import 'package:${pubspecConfig.projectName}/${pubspecConfig.databasePath}';",
        "import 'package:${joinAll(modelDirectory)}';",
        "import 'package:${joinAll(tableDirectory)}';",
        if (pubspecConfig.generateInjectableInDaos) "import 'package:injectable/injectable.dart';",
        ...additionalImports,
      },
      jsonModel: jsonModel,
      pubspecConfig: pubspecConfig,
      ymlConfig: ymlConfig,
      extendsFields: extendsFields,
      sb: sb,
      isForDao: true,
    );

    final modelNameUpperCamelCase = CaseUtil(jsonModel.name).upperCamelCase;
    final modelNameLowerCamelCase = CaseUtil(jsonModel.name).camelCase;
    final daoClassName = '${modelNameUpperCamelCase}DaoStorage';
    final databaseClass = CaseUtil(pubspecConfig.databasePath.split('/').last.split('.').first).upperCamelCase;

    sb.writeln("part '${jsonModel.fileName}_dao_storage.g.dart';");
    sb.writeln();

    if (pubspecConfig.generateInjectableInDaos) sb.writeln('@lazySingleton');
    sb.writeln('abstract class $daoClassName {');
    if (pubspecConfig.generateInjectableInDaos) sb.writeln('  @factoryMethod');
    sb.writeln('  factory $daoClassName($databaseClass db) = _$daoClassName;');
    sb.writeln('');
    sb.writeln('  Stream<List<$modelNameUpperCamelCase>> getAll${modelNameUpperCamelCase}sStream();');
    sb.writeln('');
    sb.writeln('  Future<List<$modelNameUpperCamelCase>> getAll${modelNameUpperCamelCase}s();');
    sb.writeln('');
    sb.writeln('  Future<void> create$modelNameUpperCamelCase($modelNameUpperCamelCase $modelNameLowerCamelCase);');
    sb.writeln('');
    sb.writeln('  Future<void> update$modelNameUpperCamelCase($modelNameUpperCamelCase $modelNameLowerCamelCase);');
    sb.writeln('}');
    sb.writeln('');
    sb.writeln('@DriftAccessor(tables: [');
    sb.writeln('  Db${modelNameUpperCamelCase}Table,');
    for (final table in otherTables) {
      sb.writeln('  Db${CaseUtil(table).upperCamelCase}Table,');
    }
    sb.writeln('])');
    sb.writeln('class _$daoClassName extends DatabaseAccessor<$databaseClass> with ${r'_$'}_${daoClassName}Mixin implements $daoClassName {');
    sb.writeln('  _$daoClassName(super.db);');
    sb.writeln('');

    final fieldsNotInTable = FieldUtil.getFieldsNotInTable(jsonModel);
    final getDbModelCall = jsonModel.fields.any((field) => field.onlyForTable) ? 'getDbModel()' : 'dbModel';

    sb.writeln('  @override');
    sb.write('  Stream<List<$modelNameUpperCamelCase>> getAll${modelNameUpperCamelCase}sStream() ');
    if (otherTables.isNotEmpty) {
      sb.writeln('{');
      for (final field in fieldsFromOtherTables) {
        sb.writeln("    final ${field.name}Table = db${field.type.name}Table.createAlias('${field.name}');");
      }
      sb.writeln('    return select(db${modelNameUpperCamelCase}Table)');
      sb.writeln('        .join([');
      for (final tableField in fieldsFromOtherTables) {
        // N:N relation
        if (tableField.type is ArrayType) {
          final inbetweenTableName = 'db${jsonModel.name}${CaseUtil(tableField.name).upperCamelCase}Table';
          sb.write('          leftOuterJoin($inbetweenTableName, ');
          sb.write(jsonModel.fields
              .where((element) => element.isTablePrimaryKey)
              .map((field) => '$inbetweenTableName.${field.name}.equalsExp(db${modelNameUpperCamelCase}Table.${field.name})')
              .join(' & '));
          sb.writeln('),');
          sb.write('          leftOuterJoin(${tableField.name}Table, ');
          sb.write(primaryKeys[tableField.type]!
              .map((field) => '${tableField.name}Table.${field.name}.equalsExp($inbetweenTableName.${tableField.name}${CaseUtil(field.name).upperCamelCase})')
              .join(' & '));
          sb.writeln('),');
        } else {
          sb.write('          leftOuterJoin(${tableField.name}Table, ');
          sb.write(primaryKeys[tableField.type]!
              .map((field) => '${tableField.name}Table.${field.name}.equalsExp(db${modelNameUpperCamelCase}Table.${tableField.name}${CaseUtil(field.name).upperCamelCase})')
              .join(' & '));
          sb.writeln('),');
        }
      }
      sb.writeln('        ])');
      sb.writeln('        .watch()');
      sb.writeln('        .map((rows) {');
      sb.writeln('          final items = <Db$modelNameUpperCamelCase>[];');
      for (final field in fieldsFromOtherTables) {
        final fieldType = field.type is ArrayType ? 'List<${field.type.name}>' : field.type.name;
        sb.writeln('          final ${field.name}Map = <Db$modelNameUpperCamelCase, $fieldType>{};');
      }
      sb.writeln('          for (final row in rows) {');
      sb.writeln('            final item = row.readTable(db${modelNameUpperCamelCase}Table);');
      for (final field in fieldsFromOtherTables) {
        final isNullable = !field.isRequired && !field.disallowNull;
        sb.writeln('            final ${field.name} = row.readTable${isNullable || field.type is ArrayType ? 'OrNull' : ''}(${field.name}Table);');
        if (field.type is ArrayType) {
          if (isNullable) sb.writeln('            if (${field.name} != null) {');
          sb.writeln('            ${isNullable ? '  ' : ''}${field.name}Map[item] ??= [];');
          if (!isNullable) sb.writeln('            if (${field.name} != null) {');
          sb.writeln('              ${field.name}Map[item]!.add(${field.name}.model);');
          sb.writeln('            }');
        } else {
          sb.write('            ');
          if (isNullable) sb.write('if (${field.name} != null) ');
          sb.writeln('${field.name}Map[item] = ${field.name}.model;');
        }
      }

      sb.writeln('          }');
      sb.writeln('');
      sb.writeln('          return items');
      sb.writeln('              .map((item) => item.getModel(');
      for (final field in fieldsFromOtherTables) {
        sb.writeln('                    ${field.name}: ${field.name}Map[item]${field.isRequired || field.disallowNull ? '!' : ''},');
      }
      sb.writeln('                  ))');
      sb.writeln('              .toList();');
      sb.writeln('        });');
      sb.writeln('  }');
    } else {
      final fieldsNotInTableAssingmentString = fieldsNotInTable.map((e) => '${e.name}: ${e.name}').join(', ');
      final getModelCall = fieldsNotInTableAssingmentString.isNotEmpty ? 'getModel($fieldsNotInTableAssingmentString)' : 'model';
      sb.writeln('=> select(db${modelNameUpperCamelCase}Table).map((item) => item.$getModelCall).watch();');
    }
    sb.writeln('');
    sb.writeln('  @override');
    sb.writeln('  Future<List<$modelNameUpperCamelCase>> getAll${modelNameUpperCamelCase}s() => getAll${modelNameUpperCamelCase}sStream().first;');
    sb.writeln('');
    sb.writeln('  @override');
    sb.writeln('  Future<void> create$modelNameUpperCamelCase($modelNameUpperCamelCase $modelNameLowerCamelCase) async {');
    final hasDbModelMethod = jsonModel.fields.any((element) => element.onlyForTable && !element.ignoreForTable);
    sb.writeln('    await into(db${modelNameUpperCamelCase}Table).insert($modelNameLowerCamelCase.${hasDbModelMethod ? 'getDbModel()' : 'dbModel'});');
    for (final field in fieldsFromOtherTables) {
      final nullable = !field.isRequired && !field.disallowNull;
      if (field.type is ArrayType) {
        final table = 'db$modelNameUpperCamelCase${CaseUtil(field.name).upperCamelCase}Table';
        final tableModel = 'Db$modelNameUpperCamelCase${CaseUtil(field.name).upperCamelCase}';
        if (nullable) {
          sb.writeln('    if ($modelNameLowerCamelCase.${field.name} != null && $modelNameLowerCamelCase.${field.name}!.isNotEmpty) {');
        } else {
          sb.writeln('    if ($modelNameLowerCamelCase.${field.name}.isNotEmpty) {');
        }
        sb.writeln('      await batch((batch) {');
        sb.writeln('        batch');
        sb.writeln('          ..insertAll(');
        sb.writeln('              $table,');
        sb.writeln('              $modelNameLowerCamelCase.${field.name}${nullable ? '!' : ''}.map((item) => $tableModel(');
        sb.write(jsonModel.fields
            .where((element) => element.isTablePrimaryKey)
            .map((primaryKeyField) => '                    ${primaryKeyField.name}: $modelNameLowerCamelCase.${primaryKeyField.name},\n')
            .join());
        sb.write(primaryKeys[field.type]!
            .map((primaryKeyField) => '                    ${field.name}${CaseUtil(primaryKeyField.name).upperCamelCase}: item.${primaryKeyField.name},\n')
            .join());
        sb.writeln('                  )))');
        sb.writeln('          ..insertAll(db${field.type.name}Table, $modelNameLowerCamelCase.${field.name}${nullable ? '!' : ''}.map((item) => item.dbModel));');
        sb.writeln('      });');
        sb.writeln('    }');
      } else {
        final table = 'db${field.type.name}Table';
        sb.write('    ');
        if (nullable) sb.write('if ($modelNameLowerCamelCase.${field.name} != null) ');
        sb.writeln('await into($table).insert($modelNameLowerCamelCase.${field.name}${nullable ? '!' : ''}.dbModel);'); // TODO: dbModel vs getDbModel()
      }
    }
    sb.writeln('  }');

    sb.writeln('');
    sb.writeln('  @override');
    sb.writeln(
        '  Future<void> update$modelNameUpperCamelCase($modelNameUpperCamelCase $modelNameLowerCamelCase) => update(db${modelNameUpperCamelCase}Table).replace($modelNameLowerCamelCase.$getDbModelCall);');
    sb.writeln('}');

    return sb.toString();
  }
}
