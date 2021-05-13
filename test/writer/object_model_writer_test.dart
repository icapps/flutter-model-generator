import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/date_time_type.dart';
import 'package:model_generator/model/item_type/map_type.dart';
import 'package:model_generator/model/item_type/object_type.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'writer_test_helper.dart';

void main() {
  group('ObjectModelWriter', () {
    test('Normal ObjectModelWriter with not required field', () {
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
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'normal');
    });
    test(
        'Normal ObjectModelWriter with not required field - equals and hashcode',
        () {
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
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(
          model, [], 'normal-equals-hashcode');
    });
    test('Normal ObjectModelWriter with extra annotations', () {
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
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'extra-imports');
    });
    test('Normal ObjectModelWriter with toString', () {
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
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'normal-to-string');
    });
    test('Normal ObjectModelWriter with extra annotations on model', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        extraAnnotations: ['@veryGood'],
        extraImports: ['testing:package.dart'],
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
      WriterTestHelper.testObjectModelWriter(
          model, [], 'extra-imports-on-model');
    });
    test('Normal ObjectModelWriter with required field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'required');
    });
    test('Nullsafe ObjectModelWriter with required field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
          Field(
            name: 'lastName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'nullsafety');
    });

    test('ObjectModelWriter with generate for generics default option', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: true,
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
      WriterTestHelper.testObjectModelWriter(
          model, [], 'generate-for-generics');
    });

    test('ObjectModelWriter with generate for generics override option', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: true,
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
      WriterTestHelper.testObjectModelWriter(
          model, [], 'generate-for-generics-override');
    });

    test('ObjectModelWriter with generate for generics override option 2', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(
          model, [], 'generate-for-generics-override-2');
    });

    test('Normal ObjectModelWriter with ignroe field', () {
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
            ignore: true,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'ignore');
    });

    test('Normal ObjectModelWriter with array field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'array');
    });

    test('Normal ObjectModelWriter with map field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'info',
            type: MapType(key: 'String', valueName: 'int'),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'map');
    });

    test('Normal ObjectModelWriter with map field with reference', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'info',
            type: MapType(key: 'String', valueName: 'Person'),
            isRequired: false,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'map-reference');
    });

    test('Normal ObjectModelWriter with non final', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'non-final');
    });

    test('Normal ObjectModelWriter with do not includeIfNull', () {
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
            includeIfNull: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'include-if-null');
    });

    test('Normal ObjectModelWriter with do not includeIfNull', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'unknown-enum-value');
    });

    test('Normal ObjectModelWriter with custom from to', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'custom-from-to');
    });

    test('Normal ObjectModelWriter with sorting required fields', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'sort');
    });

    test('Normal ObjectModelWriter with converter', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'converter');
    });

    test('Normal ObjectModelWriter with dart import', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'dart-import');
    });

    test('Normal ObjectModelWriter with extended fields', () {
      final model = ObjectModel(
        name: 'User',
        extend: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'email',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      final extendsFields = [
        Field(
          name: 'name',
          type: StringType(),
          isRequired: true,
          ignore: false,
          includeIfNull: true,
          nonFinal: false,
        ),
      ];
      WriterTestHelper.testObjectModelWriter(
          model, extendsFields, 'extend-fields');
    });

    test('Normal ObjectModelWriter with extended fields twice', () {
      final model = ObjectModel(
        name: 'Admin',
        extend: 'User',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'permission',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      final extendsFields = [
        Field(
          name: 'name',
          type: StringType(),
          isRequired: true,
          ignore: false,
          includeIfNull: true,
          nonFinal: false,
        ),
        Field(
          name: 'email',
          type: StringType(),
          isRequired: true,
          ignore: false,
          includeIfNull: true,
          nonFinal: false,
        ),
      ];
      WriterTestHelper.testObjectModelWriter(
          model, extendsFields, 'extend-fields-twice');
    });

    test('Normal ObjectModelWriter with package import', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'package-import');
    });

    test('Normal ObjectModelWriter with package import and .dart', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'dart-package-import');
    });

    test('Normal ObjectModelWriter without path', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
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
      WriterTestHelper.testObjectModelWriter(model, [], 'without-path');
    });
  });
}
