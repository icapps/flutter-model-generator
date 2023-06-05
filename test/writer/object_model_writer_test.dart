import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/item_type/array_type.dart';
import 'package:model_generator/model/item_type/date_time_type.dart';
import 'package:model_generator/model/item_type/map_type.dart';
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
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
              name: 'firstName',
              type: StringType(),
              isRequired: false,
              ignore: false,
              includeFromJson: true,
              includeToJson: true,
              includeIfNull: true,
              ignoreEquality: false,
              nonFinal: false,
              description: 'A good description'),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'normal');
    });

    test('Normal ObjectModelWriter with not required field - equals and hashcode', () {
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
            includeFromJson: true,
            includeToJson: true,
            ignoreEquality: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'normal-equals-hashcode');
    });

    test('Normal ObjectModelWriter with explicit to json false', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        explicitToJson: false,
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            ignoreEquality: false,
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'explicit-to-json-false');
    });
    test('Normal ObjectModelWriter with explicit to json false in pubspec', () {
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
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'explicit-to-json-false-pubspec');
    });
    test('Normal ObjectModelWriter with extra annotations', () {
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
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            ignoreEquality: false,
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
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
        staticCreate: false,
        extraAnnotations: ['@veryGood'],
        extraImports: ['testing:package.dart'],
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'extra-imports-on-model');
    });
    test('Normal ObjectModelWriter with required field', () {
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
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            ignoreEquality: false,
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
          ),
          Field(
            name: 'lastName',
            type: StringType(),
            isRequired: false,
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            ignoreEquality: false,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'generate-for-generics');
    });

    test('ObjectModelWriter with generate for generics override option', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: true,
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: true,
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'generate-for-generics-override');
    });

    test('ObjectModelWriter with generate for generics override option 2', () {
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
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'generate-for-generics-override-2');
    });

    test('Normal ObjectModelWriter with includeFromJson field', () {
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
            includeFromJson: false,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'includeFromJson');
    });
    test('Normal ObjectModelWriter with includeToJson field', () {
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
            includeFromJson: true,
            includeToJson: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'includeToJson');
    });

    test('Normal ObjectModelWriter with includeFromJson and includeToJson field', () {
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
            includeFromJson: false,
            includeToJson: false,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'includeToJson-includeFromJson');
    });

    test('Normal ObjectModelWriter with import sorting', () {
      final model = ObjectModel(
        name: 'BModel',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'aModel',
            type: ObjectType('AModel'),
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'import_sorting');
    });

    test('Normal ObjectModelWriter with array field', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'info',
            type: ArrayType('String'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'info',
            type: MapType(key: 'String', valueName: 'int'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
            ignoreEquality: false,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'info',
            type: MapType(key: 'String', valueName: 'Person'),
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'gender',
            type: StringType(),
            isRequired: false,
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'gender',
            type: ObjectType('Gender'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
            unknownEnumValue: 'X',
            ignoreEquality: false,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'time',
            type: ObjectType('Time'),
            isRequired: false,
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'b',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            ignoreEquality: false,
            includeIfNull: true,
            nonFinal: false,
          ),
          Field(
            name: 'x',
            type: StringType(),
            isRequired: true,
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
          ),
          Field(
            name: 'a',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
            ignoreEquality: false,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'birthday',
            type: DateTimeType(),
            isRequired: false,
            ignoreEquality: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            ignoreEquality: false,
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
        extendsModel: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'email',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
            ignoreEquality: false,
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
          includeFromJson: true,
          includeToJson: true,
          includeIfNull: true,
          nonFinal: false,
          ignoreEquality: false,
        ),
      ];
      WriterTestHelper.testObjectModelWriter(model, extendsFields, 'extend-fields');
    });

    test('Normal ObjectModelWriter with extended fields', () {
      final model = ObjectModel(
        name: 'User',
        extendsModel: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'email',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
            ignoreEquality: false,
          ),
        ],
        converters: [],
      );
      final extendsFields = [
        Field(
          name: 'address',
          type: ObjectType('Address'),
          isRequired: true,
          ignore: false,
          includeFromJson: true,
          includeToJson: true,
          includeIfNull: true,
          nonFinal: false,
          ignoreEquality: false,
        ),
        Field(
          name: 'info',
          type: MapType(key: 'String', valueName: 'Address'),
          isRequired: false,
          ignore: false,
          includeFromJson: true,
          includeToJson: true,
          includeIfNull: true,
          nonFinal: false,
          ignoreEquality: false,
        ),
      ];
      WriterTestHelper.testObjectModelWriter(model, extendsFields, 'extend-fields-with-non-dart-type');
    });

    test('Normal ObjectModelWriter with extended fields twice', () {
      final model = ObjectModel(
        name: 'Admin',
        extendsModel: 'User',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        fields: [
          Field(
            name: 'permission',
            type: StringType(),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
            ignoreEquality: false,
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
          includeFromJson: true,
          includeToJson: true,
          includeIfNull: true,
          nonFinal: false,
          ignoreEquality: false,
        ),
        Field(
          name: 'email',
          type: StringType(),
          isRequired: true,
          ignore: false,
          includeFromJson: true,
          includeToJson: true,
          includeIfNull: true,
          nonFinal: false,
          ignoreEquality: false,
        ),
      ];
      WriterTestHelper.testObjectModelWriter(model, extendsFields, 'extend-fields-twice');
    });

    test('Normal ObjectModelWriter with package import', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
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
        staticCreate: false,
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
            ignoreEquality: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'without-path');
    });

    test('Normal ObjectModelWriter with toJson & fromJson', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            nonFinal: false,
            toJson: 'handleToJson',
            fromJson: 'handleFromJson',
            ignoreEquality: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'to-json-from-json');
    });

    test('Normal ObjectModelWriter with toJson & fromJson extra imports', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        extraImports: ['testing:handler.dart'],
        fields: [
          Field(
            name: 'address',
            type: ObjectType('Address'),
            isRequired: true,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
            toJson: 'Handler.handleToJson',
            fromJson: 'Handler.handleFromJson',
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'to-json-from-json-handler');
    });

    test('Normal ObjectModelWriter with static create', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: true,
        fields: [
          Field(
              name: 'firstName',
              type: StringType(),
              isRequired: false,
              ignore: false,
              includeFromJson: true,
              includeToJson: true,
              includeIfNull: true,
              ignoreEquality: false,
              nonFinal: false,
              description: 'A good description'),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'normal-static-create');
    });

    test('Normal ObjectModelWriter with all fields ignored from equals hashcode', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        equalsAndHashCode: true,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: true,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'normal-equals-hashcode-empty');
    });
    test('Normal ObjectModelWriter with some fields ignored from equals hashcode', () {
      final model = ObjectModel(
        name: 'Person',
        path: 'path_to_my_model',
        baseDirectory: 'base_dir',
        generateForGenerics: false,
        staticCreate: false,
        equalsAndHashCode: true,
        fields: [
          Field(
            name: 'firstName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: true,
            nonFinal: false,
          ),
          Field(
            name: 'lastName',
            type: StringType(),
            isRequired: false,
            ignore: false,
            includeFromJson: true,
            includeToJson: true,
            includeIfNull: true,
            ignoreEquality: false,
            nonFinal: false,
          ),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'normal-equals-hashcode-some-ignored');
    });
    test('Normal ObjectModelWriter with default field', () {
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
              includeFromJson: true,
              includeToJson: true,
              includeIfNull: true,
              ignoreEquality: false,
              nonFinal: false,
              defaultValue: '\'test\'',
              description: 'A good description'),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'default-field');
    });
    test('Normal ObjectModelWriter with description', () {
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
                includeFromJson: true,
                includeToJson: true,
                includeIfNull: true,
                ignoreEquality: false,
                nonFinal: false,
                defaultValue: '\'test\'',
                description: 'A good description'),
          ],
          converters: [],
          description: 'A good class description');
      WriterTestHelper.testObjectModelWriter(model, [], 'normal-with-description');
    });
    test('Normal ObjectModelWriter with default required field', () {
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
              includeFromJson: true,
              includeToJson: true,
              includeIfNull: true,
              ignoreEquality: false,
              nonFinal: false,
              defaultValue: '\'test\'',
              description: 'A good description'),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'default-field-required');
    });
    test('Normal ObjectModelWriter with default required field disallow null', () {
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
              includeFromJson: true,
              includeToJson: true,
              includeIfNull: true,
              ignoreEquality: false,
              nonFinal: false,
              disallowNull: true,
              defaultValue: '\'test\'',
              description: 'A good description'),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'default-field-required-null-disallowed');
    });
    test('Normal ObjectModelWriter with retrofit compute', () {
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
              includeFromJson: true,
              includeToJson: true,
              includeIfNull: true,
              ignoreEquality: false,
              nonFinal: false,
              description: 'A good description'),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'normal-retrofit-compute');
    });
    test('Normal ObjectModelWriter with retrofit compute - tearoff', () {
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
              includeFromJson: true,
              includeToJson: true,
              includeIfNull: true,
              ignoreEquality: false,
              nonFinal: false,
              description: 'A good description'),
        ],
        converters: [],
      );
      WriterTestHelper.testObjectModelWriter(model, [], 'retrofit-compute-tearoff');
    });
  });
}
