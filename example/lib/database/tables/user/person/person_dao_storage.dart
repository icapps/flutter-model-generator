// THIS CODE WILL NOT REGENERATE UNLESS THIS FILE IS DELETED - FEEL FREE TO MODIFY BY HAND!

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/database/tables/user/person/person_table.dart';
import 'package:model_generator_example/model/user/person/person.dart';

part 'person_dao_storage.g.dart';

@lazySingleton
abstract class PersonDaoStorage {
  @factoryMethod
  factory PersonDaoStorage(ModelGeneratorExampleDatabase db) = _PersonDaoStorage;

  Stream<List<Person>> getAllPersonsStream();

  Future<List<Person>> getAllPersons();

  Future<void> createPerson(Person person);

  Future<void> updatePerson(Person person);
}

@DriftAccessor(tables: [
  DbPersonTable,
])
class _PersonDaoStorage extends DatabaseAccessor<ModelGeneratorExampleDatabase> with _$_PersonDaoStorageMixin implements PersonDaoStorage {
  _PersonDaoStorage(super.db);

  @override
  Stream<List<Person>> getAllPersonsStream() => select(dbPersonTable).map((item) => item.model).watch();

  @override
  Future<List<Person>> getAllPersons() => getAllPersonsStream().first;

  @override
  Future<void> createPerson(Person person) async => into(dbPersonTable).insert(person.dbModel);

  @override
  Future<void> updatePerson(Person person) => update(dbPersonTable).replace(person.dbModel);
}
