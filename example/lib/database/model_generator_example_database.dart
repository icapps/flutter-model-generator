import 'package:drift/drift.dart';
import 'package:model_generator_example/database/tables/book/book_table.dart';
import 'package:model_generator_example/database/tables/user/person/person_table.dart';
import 'package:model_generator_example/model/book/book_category.dart';

part 'model_generator_example_database.g.dart';

@DriftDatabase(tables: [
  DbBookTable,
  DbPersonTable,
  DbBookEditorsTable,
  DbBookTranslatorsTable,
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
