// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:drift/drift.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/model/user/person/gender.dart';
import 'package:model_generator_example/model/user/person/person.dart';

@DataClassName('DbPerson')
class DbPersonTable extends Table {
  @override
  Set<Column> get primaryKey => {firstName, lastName};

  TextColumn get firstName => text()();

  TextColumn get gender => text().map(const PersonTableGenderConverter())();

  TextColumn get lastName => text().nullable()();
}

extension DbPersonExtension on DbPerson {
  Person get model => Person(
        firstName: firstName,
        lastName: lastName,
        gender: gender,
      );
}

extension PersonExtension on Person {
  DbPerson get dbModel => DbPerson(
        firstName: firstName,
        gender: gender,
        lastName: lastName,
      );
}

class PersonTableGenderConverter extends TypeConverter<Gender, String> {
  const PersonTableGenderConverter();

  @override
  Gender fromSql(String fromDb) {
    for (final value in Gender.values) {
      if (value.jsonValue == fromDb) return value;
    }
    return Gender.values.first;
  }

  @override
  String toSql(Gender value) {
    return value.jsonValue;
  }
}
