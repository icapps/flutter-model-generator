// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:drift/drift.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/model/book/book.dart';
import 'package:model_generator_example/model/book/book_category.dart';
import 'package:model_generator_example/model/user/person/person.dart';
import 'package:model_generator_example/util/converters/string_list_converter.dart';

@DataClassName('DbBook')
class DbBookTable extends Table {
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get name => text()();

  DateTimeColumn get publishingDate => dateTime()();

  BoolColumn get isAvailable => boolean()();

  TextColumn get category => text().map(const BookTableBookCategoryConverter())();

  RealColumn get price => real().nullable()();

  IntColumn get pages => integer().nullable()();

  TextColumn get tags => text().map(const StringListConverter()).nullable()();

  TextColumn get secondCategory => text().map(const BookTableBookCategoryNullableConverter()).nullable()();

  TextColumn get onlyInDb => text().nullable()();
}

extension DbBookExtension on DbBook {
  Book getModel({required List<Person> authors, List<Person>? publishers}) => Book(
        id: id,
        name: name,
        publishingDate: publishingDate,
        price: price,
        pages: pages,
        isAvailable: isAvailable,
        authors: authors,
        publishers: publishers,
        tags: tags,
        category: category,
        secondCategory: secondCategory,
      );
}

extension BookExtension on Book {
  DbBook getModel({String? onlyInDb}) => DbBook(
        id: id,
        name: name,
        publishingDate: publishingDate,
        isAvailable: isAvailable,
        category: category,
        price: price,
        pages: pages,
        tags: tags,
        secondCategory: secondCategory,
        onlyInDb: onlyInDb,
      );
}

class BookTableBookCategoryConverter extends TypeConverter<BookCategory, String> {
  const BookTableBookCategoryConverter();

  @override
  BookCategory fromSql(String fromDb) {
    for (final value in BookCategory.values) {
      if (value.jsonValue == fromDb) return value;
    }
    return BookCategory.values.first;
  }

  @override
  String toSql(BookCategory value) {
    return value.jsonValue;
  }
}

class BookTableBookCategoryNullableConverter extends TypeConverter<BookCategory?, String?> {
  const BookTableBookCategoryNullableConverter();

  @override
  BookCategory? fromSql(String? fromDb) {
    for (final value in BookCategory.values) {
      if (value.jsonValue == fromDb) return value;
    }
    return null;
  }

  @override
  String? toSql(BookCategory? value) {
    return value?.jsonValue;
  }
}
