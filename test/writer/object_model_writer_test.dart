import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/date_time_type.dart';
import 'package:model_generator/model/item_type/object_type.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:test/test.dart';

import 'writer_test_helper.dart';

void main() {
  group('ObjectModelWriter', () {
    test('Normal ObjectModelWriter with not required field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'normal');
    });
    test('Normal ObjectModelWriter with required field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'required');
    });

    test('Normal ObjectModelWriter with ignroe field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: true,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'ignore');
    });

    test('Normal ObjectModelWriter with array field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'info',
            type: ArrayType('String'),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'array');
    });

    test('Normal ObjectModelWriter with non final', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'gender',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            nonFinal: true,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'non-final');
    });

    test('Normal ObjectModelWriter with do not includeIfNull', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'include-if-null');
    });

    test('Normal ObjectModelWriter with do not includeIfNull', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'gender',
            type: ObjectType('Gender'),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
            unknownEnumValue: 'X',
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'unknown-enum-value');
    });

    test('Normal ObjectModelWriter with custom from to', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'time',
            type: ObjectType('Time'),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            nonFinal: true,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'custom-from-to');
    });

    test('Normal ObjectModelWriter with sorting required fields', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'b',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
          Field(
            name: 'x',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
          Field(
            name: 'a',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'sort');
    });

    test('Normal ObjectModelWriter with converter', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'birthday',
            type: DateTimeType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [
          'DateTimeConverter',
        ],
      );
      WriterTestHelper.testObjectModelWriter(model, 'converter');
    });

    test('Normal ObjectModelWriter with dart import', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'dart-import');
    });

    test('Normal ObjectModelWriter with package import', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'package-import');
    });

    test('Normal ObjectModelWriter with package import and .dart', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'dart-package-import');
    });


    test('Normal ObjectModelWriter without path', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, 'without-path');
    });
  });
}
