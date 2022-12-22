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
      WriterTestHelper.testDriftModelWriter(model, [], 'normal');
    });

    test('Normal DriftModelWriter with specified databasePath', () {
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
      WriterTestHelper.testDriftModelWriter(model, [], 'normal');
    });

    test('Normal DriftModelWriter normal fields', () {
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
  });
}
