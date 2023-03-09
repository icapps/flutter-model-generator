// THIS CODE WILL NOT REGENERATE UNLESS THIS FILE IS DELETED - FEEL FREE TO MODIFY BY HAND!

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/database/tables/book/book_table.dart';
import 'package:model_generator_example/database/tables/user/person/person_table.dart';
import 'package:model_generator_example/model/book/book.dart';
import 'package:model_generator_example/model/user/person/person.dart';

part 'book_dao_storage.g.dart';

@lazySingleton
abstract class BookDaoStorage {
  @factoryMethod
  factory BookDaoStorage(ModelGeneratorExampleDatabase db) = _BookDaoStorage;

  Stream<List<Book>> getAllBooksStream();

  Future<List<Book>> getAllBooks();

  Future<void> createBook(Book book);

  Future<void> updateBook(Book book);
}

@DriftAccessor(tables: [
  DbBookTable,
  DbBookEditorsTable,
  DbBookTranslatorsTable,
  DbPersonTable,
])
class _BookDaoStorage extends DatabaseAccessor<ModelGeneratorExampleDatabase> with _$_BookDaoStorageMixin implements BookDaoStorage {
  _BookDaoStorage(super.db);

  @override
  Stream<List<Book>> getAllBooksStream() {
    final editorsTable = dbPersonTable.createAlias('editors');
    final translatorsTable = dbPersonTable.createAlias('translators');
    final authorTable = dbPersonTable.createAlias('author');
    final publisherTable = dbPersonTable.createAlias('publisher');
    return select(dbBookTable)
        .join([
          leftOuterJoin(dbBookEditorsTable, dbBookEditorsTable.id.equalsExp(dbBookTable.id)),
          leftOuterJoin(editorsTable, editorsTable.firstName.equalsExp(dbBookEditorsTable.editorsFirstName) & editorsTable.lastName.equalsExp(dbBookEditorsTable.editorsLastName)),
          leftOuterJoin(dbBookTranslatorsTable, dbBookTranslatorsTable.id.equalsExp(dbBookTable.id)),
          leftOuterJoin(translatorsTable, translatorsTable.firstName.equalsExp(dbBookTranslatorsTable.translatorsFirstName) & translatorsTable.lastName.equalsExp(dbBookTranslatorsTable.translatorsLastName)),
          leftOuterJoin(authorTable, authorTable.firstName.equalsExp(dbBookTable.authorFirstName) & authorTable.lastName.equalsExp(dbBookTable.authorLastName)),
          leftOuterJoin(publisherTable, publisherTable.firstName.equalsExp(dbBookTable.publisherFirstName) & publisherTable.lastName.equalsExp(dbBookTable.publisherLastName)),
        ])
        .watch()
        .map((rows) {
          final items = <DbBook>[];
          final editorsMap = <DbBook, List<Person>>{};
          final translatorsMap = <DbBook, List<Person>>{};
          final authorMap = <DbBook, Person>{};
          final publisherMap = <DbBook, Person>{};
          for (final row in rows) {
            final item = row.readTable(dbBookTable);
            final editors = row.readTableOrNull(editorsTable);
            editorsMap[item] ??= [];
            if (editors != null) {
              editorsMap[item]!.add(editors.model);
            }
            final translators = row.readTableOrNull(translatorsTable);
            if (translators != null) {
              translatorsMap[item] ??= [];
              translatorsMap[item]!.add(translators.model);
            }
            final author = row.readTable(authorTable);
            authorMap[item] = author.model;
            final publisher = row.readTableOrNull(publisherTable);
            if (publisher != null) publisherMap[item] = publisher.model;
          }

          return items
              .map((item) => item.getModel(
                    editors: editorsMap[item]!,
                    translators: translatorsMap[item],
                    author: authorMap[item]!,
                    publisher: publisherMap[item],
                  ))
              .toList();
        });
  }

  @override
  Future<List<Book>> getAllBooks() => getAllBooksStream().first;

  @override
  Future<void> createBook(Book book) async {
    await into(dbBookTable).insert(book.getDbModel());
    if (book.editors.isNotEmpty) {
      await batch((batch) {
        batch
          ..insertAll(
              dbBookEditorsTable,
              book.editors.map((item) => DbBookEditors(
                    id: book.id,
                    editorsFirstName: item.firstName,
                    editorsLastName: item.lastName,
                  )))
          ..insertAll(dbPersonTable, book.editors.map((item) => item.dbModel));
      });
    }
    if (book.translators != null && book.translators!.isNotEmpty) {
      await batch((batch) {
        batch
          ..insertAll(
              dbBookTranslatorsTable,
              book.translators!.map((item) => DbBookTranslators(
                    id: book.id,
                    translatorsFirstName: item.firstName,
                    translatorsLastName: item.lastName,
                  )))
          ..insertAll(dbPersonTable, book.translators!.map((item) => item.dbModel));
      });
    }
    await into(dbPersonTable).insert(book.author.dbModel);
    if (book.publisher != null) await into(dbPersonTable).insert(book.publisher!.dbModel);
  }

  @override
  Future<void> updateBook(Book book) => update(dbBookTable).replace(book.getDbModel());
}
