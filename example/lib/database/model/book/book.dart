import 'package:drift/drift.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/model/book/book.dart';
import 'package:model_generator_example/model/book/book_category.dart';
import 'package:model_generator_example/model/user/person/person.dart';

@DataClassName('DbBook')
class DbBookTable extends Table {
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get name => text()();

  DateTimeColumn get publishingDate => dateTime()();

  BoolColumn get isAvailable => boolean()();

  TextColumn get category =>
      text().map(const BookTableBookCategoryConverter())();

  RealColumn get price => real().nullable()();

  IntColumn get pages => integer().nullable()();

  TextColumn get secondCategory =>
      text().map(const BookTableBookCategoryConverter()).nullable()();
}

extension DbBookExtension on DbBook {
  Book getModel({required List<Person> authors, List<Person>? publishers}) =>
      Book(
        id: id,
        name: name,
        publishingDate: publishingDate,
        isAvailable: isAvailable,
        authors: authors,
        category: category,
        price: price,
        pages: pages,
        publishers: publishers,
        secondCategory: secondCategory,
      );
}

extension BookExtension on Book {
  DbBook get dbModel => DbBook(
        id: id,
        name: name,
        publishingDate: publishingDate,
        isAvailable: isAvailable,
        category: category,
        price: price,
        pages: pages,
        secondCategory: secondCategory,
      );
}

class BookTableBookCategoryConverter
    extends TypeConverter<BookCategory, String> {
  const BookTableBookCategoryConverter();

  @override
  BookCategory fromSql(String fromDb) {
    for (final value in BookCategory.values) {
      if (value.toString() == fromDb) return value;
    }
    return BookCategory.values.first;
  }

  @override
  String toSql(BookCategory value) {
    return value.toString();
  }
}
