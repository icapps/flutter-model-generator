import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
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

    final sb = StringBuffer();
    final modelDirectory = [pubspecConfig.projectName, jsonModel.baseDirectory, jsonModel.path, '${jsonModel.fileName}.dart'].whereType<String>();
    final tableDirectory = [pubspecConfig.projectName, 'database', 'tables', jsonModel.path, '${jsonModel.fileName}_table.dart'].whereType<String>();

    ModelHelper.writeImports(
      initialImports: {
        "import 'package:drift/drift.dart';",
        "import 'package:${pubspecConfig.projectName}/${pubspecConfig.databasePath}';",
        "import 'package:${joinAll(modelDirectory)}';",
        "import 'package:${joinAll(tableDirectory)}';",
        if (pubspecConfig.generateInjectableInDaos) "import 'package:injectable/injectable.dart';",
      },
      jsonModel: jsonModel,
      pubspecConfig: pubspecConfig,
      yamlConfig: yamlConfig,
      extendsFields: extendsFields,
      sb: sb,
      isForTable: true,
    );

    final modelNameUpperCamelCase = CaseUtil(jsonModel.name).upperCamelCase;
    final modelNameLowerCamelCase = CaseUtil(jsonModel.name).camelCase;
    final daoClassName = '${modelNameUpperCamelCase}DaoStorage';
    final databaseClass = CaseUtil(pubspecConfig.databasePath.split('/').last.split('.').first).upperCamelCase;

    sb.writeln("part '${jsonModel.fileName}_dao_storage.g.dart';");
    sb.writeln();

    if (pubspecConfig.generateInjectableInDaos) sb.writeln('@lazySingleton');
    sb.writeln('abstract class $daoClassName {');
    sb.writeln('');
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
    sb.writeln('])');
    sb.writeln('class _$daoClassName extends DatabaseAccessor<$databaseClass> with ${r'_$'}_${daoClassName}Mixin implements $daoClassName {');
    sb.writeln('  _$daoClassName(super.db);');
    sb.writeln('');
    // TODO: Implement methods
    sb.writeln('  @override');
    sb.writeln('  Stream<List<$modelNameUpperCamelCase>> getAll${modelNameUpperCamelCase}sStream() => select(dbBookTable).map((item) => item.getModel()).watch();');
    sb.writeln('');
    sb.writeln('  @override');
    sb.writeln('  Future<List<$modelNameUpperCamelCase>> getAll${modelNameUpperCamelCase}s() => select(dbBookTable).map((item) => item.getModel()).get();');
    sb.writeln('');
    sb.writeln('  @override');
    sb.writeln('  Future<void> create$modelNameUpperCamelCase($modelNameUpperCamelCase $modelNameLowerCamelCase) async => into(dbBookTable).insert(book.getDbModel());');
    sb.writeln('');
    sb.writeln('  @override');
    // TODO: Use primary keys for update?
    sb.writeln(
        '  Future<void> update$modelNameUpperCamelCase($modelNameUpperCamelCase $modelNameLowerCamelCase) => (update(dbBookTable)..where((dbBook) => dbBook.id.equals(book.id))).write(book.getDbModel());');
    sb.writeln('}');

    return sb.toString();
  }
}


/*
class _BookDaoStorage extends DatabaseAccessor<ModelGeneratorExampleDatabase> with _$_BookDaoStorageMixin implements BookDaoStorage {
  _BookDaoStorage(super.db);

  @override
  Future<List<Book>> getAllBooks() => select(dbBookTable).map((item) => item.getModel()).get();

  @override
  Stream<List<Book>> getAllBooksStream() => select(dbBookTable).map((item) => item.getModel()).watch();

  @override
  Future<void> createBook(Book book) async => into(dbBookTable).insert(book.getDbModel());

  @override
  Future<void> updateBook(Book book) => (update(dbBookTable)..where((dbBook) => dbBook.id.equals(book.id))).write(book.getDbModel());
}
*/