import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/boolean_type.dart';
import 'package:model_generator/model/item_type/date_time_type.dart';
import 'package:model_generator/model/item_type/double_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:test/test.dart';

import 'writer_test_helper.dart';

void main() {
  group('DriftModelWriter', () {
    test('Normal DriftModelWriter', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(model, [], 'normal');
    });

    test('DriftModelWriter with multiple dart fields', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
          Field(
            name: 'boolField',
            type: BooleanType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
          Field(
            name: 'birthDay',
            type: DateTimeType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
          Field(
            name: 'doubleField',
            type: DoubleType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
          Field(
            name: 'intField',
            type: IntegerType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(model, [], 'normal_fields');
    });

    test('DriftModelWriter with nullable field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
          Field(
            name: 'lastName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(model, [], 'nullable_field');
    });

    test('DriftModelWriter with specified databasePath', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            description: 'A good description',
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(
          model, [], 'specified_database_path');
    });

    test('DriftModelWriter with ignored table field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
          Field(
            name: 'lastName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            ignoreForTable: true,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(model, [], 'with_ignore_fields');
    });

    test('DriftModelWriter with single primaryKey field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            isTablePrimaryKey: true,
          ),
          Field(
            name: 'lastName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            isTablePrimaryKey: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(model, [], 'primary_key_single');
    });

    test('DriftModelWriter with multiple primaryKey fields', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            isTablePrimaryKey: true,
          ),
          Field(
            name: 'lastName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            isTablePrimaryKey: true,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(model, [], 'primary_key_multiple');
    });

    test('DriftModelWriter with ignored table, but required field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
          Field(
            name: 'lastName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            ignoreForTable: true,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testDriftModelWriter(
          model, [], 'with_ignore_required_fields');
    });
  });
}
