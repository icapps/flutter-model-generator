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

  TextColumn get authorFirstName => text()();

  TextColumn get authorLastName => text().nullable()();

  TextColumn get category => text().map(const BookTableBookCategoryConverter())();

  RealColumn get price => real().nullable()();

  IntColumn get pages => integer().nullable()();

  TextColumn get publisherFirstName => text().nullable()();

  TextColumn get publisherLastName => text().nullable()();

  TextColumn get tags => text().map(const StringListConverter()).nullable()();

  TextColumn get secondCategory => text().map(const BookTableBookCategoryNullableConverter()).nullable()();

  TextColumn get onlyInDb => text().nullable()();
}

@DataClassName('DbBookEditors')
class DbBookEditorsTable extends Table {
  IntColumn get id => integer()();

  TextColumn get editorsFirstName => text()();

  TextColumn get editorsLastName => text().nullable()();

}

@DataClassName('DbBookTranslators')
class DbBookTranslatorsTable extends Table {
  IntColumn get id => integer()();

  TextColumn get translatorsFirstName => text()();

  TextColumn get translatorsLastName => text().nullable()();

}

extension DbBookExtension on DbBook {
  Book getModel({
    required Person author,
    required List<Person> editors,
    Person? publisher,
    List<Person>? translators,
  }) => Book(
        id: id,
        name: name,
        publishingDate: publishingDate,
        price: price,
        pages: pages,
        isAvailable: isAvailable,
        editors: editors,
        translators: translators,
        author: author,
        publisher: publisher,
        tags: tags,
        category: category,
        secondCategory: secondCategory,
      );
}

extension BookExtension on Book {
  DbBook getDbModel({String? onlyInDb}) => DbBook(
        id: id,
        name: name,
        publishingDate: publishingDate,
        isAvailable: isAvailable,
        authorFirstName: author.firstName,
        authorLastName: author.lastName,
        category: category,
        price: price,
        pages: pages,
        publisherFirstName: publisher?.firstName,
        publisherLastName: publisher?.lastName,
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
