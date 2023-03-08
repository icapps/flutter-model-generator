import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/case_util.dart';
import 'package:model_generator/util/field_util.dart';
import 'package:model_generator/util/model_helper.dart';
import 'package:path/path.dart';

class DriftDaoStorageWriter {
  final PubspecConfig pubspecConfig;
  final ObjectModel jsonModel;
  final YmlGeneratorConfig yamlConfig;

  const DriftDaoStorageWriter(
    this.pubspecConfig,
    this.jsonModel,
    this.yamlConfig,
  );

  String write() {
    final extendsFields = FieldUtil.getExtendedFields(jsonModel, yamlConfig);
    final enumFields = FieldUtil.getEnumFields(jsonModel, yamlConfig);

    final sb = StringBuffer();
    final modelDirectory = [pubspecConfig.projectName, jsonModel.baseDirectory, jsonModel.path, '${jsonModel.fileName}.dart'].whereType<String>();
    final tableDirectory = [pubspecConfig.projectName, 'database', 'tables', jsonModel.path, '${jsonModel.fileName}_table.dart'].whereType<String>();
    final additionalImports = <String>{};

    final fieldsFromOtherTables =
        jsonModel.fields.where((field) => field.typeConverterForTable == null && !enumFields.contains(field) && (field.type.driftColumn == null || field.type.driftType == null));
    final primaryKeys = <ItemType, List<Field>>{};
    final otherTables = <ObjectModel>{};
    for (final field in fieldsFromOtherTables) {
      primaryKeys[field.type] ??= FieldUtil.getPrimaryKeys(field.type, yamlConfig);
      final fieldModel = FieldUtil.getModelByType(field.type, yamlConfig);
      if (fieldModel == null) continue;
      otherTables.add(fieldModel);
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
      yamlConfig: yamlConfig,
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
      final tableName = CaseUtil(table.name).upperCamelCase;
      sb.writeln('  Db${tableName}Table,');
    }
    sb.writeln('])');
    sb.writeln('class _$daoClassName extends DatabaseAccessor<$databaseClass> with ${r'_$'}_${daoClassName}Mixin implements $daoClassName {');
    sb.writeln('  _$daoClassName(super.db);');
    sb.writeln('');

    final fieldsNotInTable = FieldUtil.getFieldsNotInTable(jsonModel);
    final fieldsNotInTableAssingmentString = fieldsNotInTable.map((e) => '${e.name}: ${e.name}').join(', ');

    final getModelCall = fieldsNotInTableAssingmentString.isNotEmpty ? 'getModel($fieldsNotInTableAssingmentString)' : 'model';
    final getDbModelCall = jsonModel.fields.any((field) => field.onlyForTable) ? 'getDbModel()' : 'dbModel';

    sb.writeln('  @override');
    sb.writeln(
        '  Stream<List<$modelNameUpperCamelCase>> getAll${modelNameUpperCamelCase}sStream() => select(db${modelNameUpperCamelCase}Table).map((item) => item.$getModelCall).watch();');
    sb.writeln('');
    sb.writeln('  @override');
    sb.writeln(
        '  Future<List<$modelNameUpperCamelCase>> getAll${modelNameUpperCamelCase}s() => select(db${modelNameUpperCamelCase}Table).map((item) => item.$getModelCall).get();');
    sb.writeln('');
    sb.writeln('  @override');
    sb.writeln(
        '  Future<void> create$modelNameUpperCamelCase($modelNameUpperCamelCase $modelNameLowerCamelCase) async => into(db${modelNameUpperCamelCase}Table).insert($modelNameLowerCamelCase.$getDbModelCall);');
    sb.writeln('');
    sb.writeln('  @override');
    sb.writeln(
        '  Future<void> update$modelNameUpperCamelCase($modelNameUpperCamelCase $modelNameLowerCamelCase) => update(db${modelNameUpperCamelCase}Table).replace($modelNameLowerCamelCase.$getDbModelCall);');
    sb.writeln('}');

    return sb.toString();
  }
}
