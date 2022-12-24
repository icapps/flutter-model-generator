import 'package:drift/drift.dart';
import 'package:model_generator_example/database/model/book/book.dart';

part 'model_generator_example_database.g.dart';

@DriftDatabase(tables: [
  DbBookTable,
])
class ModelGeneratorExampleDatabase extends _$ModelGeneratorExampleDatabase {
  ModelGeneratorExampleDatabase(QueryExecutor db) : super(db);

  @override
  int get schemaVersion => 1;

  Future<void> deleteAllData() {
    return transaction(() async {
      for (final table in allTables) {
        await delete<Table, dynamic>(table).go();
      }
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {},
    );
  }
}
