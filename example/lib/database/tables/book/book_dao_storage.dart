// THIS CODE WILL NOT REGENERATE UNLESS THIS FILE IS DELETED - FEEL FREE TO MODIFY BY HAND!

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/database/tables/book/book_table.dart';
import 'package:model_generator_example/database/tables/user/person/person_table.dart';
import 'package:model_generator_example/model/book/book.dart';

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
  DbPersonTable,
])
class _BookDaoStorage extends DatabaseAccessor<ModelGeneratorExampleDatabase> with _$_BookDaoStorageMixin implements BookDaoStorage {
  _BookDaoStorage(super.db);

  @override
  Stream<List<Book>> getAllBooksStream() => select(dbBookTable).map((item) => item.getModel(publishers: publishers, translators: translators)).watch();

  @override
  Future<List<Book>> getAllBooks() => select(dbBookTable).map((item) => item.getModel(publishers: publishers, translators: translators)).get();

  @override
  Future<void> createBook(Book book) async => into(dbBookTable).insert(book.getDbModel());

  @override
  Future<void> updateBook(Book book) => update(dbBookTable).replace(book.getDbModel());
}
