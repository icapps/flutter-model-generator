// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/database/tables/book/book_table.dart';
import 'package:model_generator_example/model/book/book.dart';
import 'package:model_generator_example/model/book/book_category.dart';
import 'package:model_generator_example/model/user/person/person.dart';
import 'package:model_generator_example/util/converters/string_list_converter.dart';

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
])
class _BookDaoStorage extends DatabaseAccessor<ModelGeneratorExampleDatabase> with _$_BookDaoStorageMixin implements BookDaoStorage {
  _BookDaoStorage(super.db);

  @override
  Stream<List<Book>> getAllBooksStream() => select(dbBookTable).map((item) => item.getModel()).watch();

  @override
  Future<List<Book>> getAllBooks() => select(dbBookTable).map((item) => item.getModel()).get();

  @override
  Future<void> createBook(Book book) async => into(dbBookTable).insert(book.getDbModel());

  @override
  Future<void> updateBook(Book book) => (update(dbBookTable)..where((dbBook) => dbBook.id.equals(book.id))).write(book.getDbModel());
}
