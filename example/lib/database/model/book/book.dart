import 'package:drift/drift.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/model/book/book.dart';
import 'package:model_generator_example/model/book/book_category.dart';
import 'package:model_generator_example/model/user/person/person.dart';

@DataClassName('DbBook')
class DbBookTable extends Table {
  TextColumn get name => text()();

  DateTimeColumn get publishingDate => dateTime()();

  BoolColumn get isAvailable => boolean()();

  TextColumn get category => text().map(const BookCategoryConverter())();

  RealColumn get price => real().nullable()();

  IntColumn get pages => integer().nullable()();
}

extension DbBookExtension on DbBook {
  Book getModel({required List<Person> authors, List<Person>? publishers}) =>
      Book(
        name: name,
        publishingDate: publishingDate,
        isAvailable: isAvailable,
        authors: authors,
        category: category,
        price: price,
        pages: pages,
        publishers: publishers,
      );
}

extension BookExtension on Book {
  DbBook get dbModel => DbBook(
        name: name,
        publishingDate: publishingDate,
        isAvailable: isAvailable,
        category: category,
        price: price,
        pages: pages,
      );
}

class BookCategoryConverter extends TypeConverter<BookCategory, String> {
  const BookCategoryConverter();

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
