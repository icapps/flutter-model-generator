import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/item_type/boolean_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:test/test.dart';

void main() {
  group('EnumModel reader test', () {
    test('Test simple enum', () {
      final models = YmlGeneratorConfig(
              PubspecConfig("name: test"),
              """
Gender:
  path: user/person/
  type: enum
  description: this is an enum
  values:
    MALE:
      description: this is a enum of male
    FEMALE:
      description: this is a enum of female
""",
              '')
          .models;

      expect(models.length, 1);
      final model = models.first;
      expect(model is EnumModel, true);
      model as EnumModel;

      expect(model.properties, isEmpty);
      expect(model.fields.length, 2);
      expect(model.addJsonKeyToProperties, true);
      expect(model.description, 'this is an enum');

      expect(model.fields[0].description, 'this is a enum of male');

      expect(model.fields[1].description, 'this is a enum of female');
    });

    test('Test complex enum', () {
      final models = YmlGeneratorConfig(
              PubspecConfig("name: test"),
              """
Gender:
  path: user/person/
  type: enum
  description: this is an enum
  use_default_json_key: false
  properties:
    abbreviation: String
    isMale:
      type: bool
      default_value: true
    name:
      type: String?
    jsonKey:
      type: int
      is_json_key: true
  values:
    MALE:
      description: this is a enum of male
      properties:
        abbreviation: m
        jsonKey: 1
    FEMALE:
      description: this is a enum of female
      properties:
        abbreviation: f
        isMale: false
        jsonKey: 2
""",
              '')
          .models;

      expect(models.length, 1);
      final model = models.first;
      expect(model is EnumModel, true);
      model as EnumModel;

      expect(model.properties.length, 4);
      expect(model.fields.length, 2);
      expect(model.addJsonKeyToProperties, false);
      expect(model.description, 'this is an enum');

      expect(model.properties[0].type, isA<StringType>());
      expect(model.properties[3].isOptional, false);

      expect(model.properties[1].defaultValue, 'true');
      expect(model.properties[1].type, isA<BooleanType>());
      expect(model.properties[3].isOptional, false);

      expect(model.properties[2].type, isA<StringType>());
      expect(model.properties[2].isOptional, true);

      expect(model.properties[3].isOptional, false);
      expect(model.properties[3].isJsonKey, true);
      expect(model.properties[3].type, isA<IntegerType>());

      expect(model.fields[0].description, 'this is a enum of male');
      expect(model.fields[0].values[0].value, 'm');
      expect(model.fields[0].values[1].value, '1');

      expect(model.fields[1].description, 'this is a enum of female');
      expect(model.fields[1].values[0].value, 'f');
      expect(model.fields[1].values[1].value, 'false');
      expect(model.fields[1].values[2].value, '2');
    });

    void testEnumError({
      required String enumYml,
      required String expectedError,
    }) {
      dynamic error;
      try {
        YmlGeneratorConfig(PubspecConfig("name: test"), enumYml, '').models;
      } catch (e) {
        error = e;
      }
      expect(error, isNotNull);
      expect(error, isException);
      if (error is Exception) {
        expect(error.toString(), expectedError);
      }
    }

    test(
        'Test enum without values',
        () => testEnumError(
              expectedError: 'Exception: Values can not be null. model: Gender',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  description: this is an enum
""",
            ));

    test(
        'Test enum with unsupported type',
        () => testEnumError(
              expectedError: 'Exception: list should have a type of integer, boolean, double or string',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  description: this is an enum
  properties:
    list: List
  values:
    MALE:
      description: this is a enum of male
      properties:
        list: []
    FEMALE:
      description: this is a enum of female
      properties:
        list: []
""",
            ));

    test(
        'Test enum with missing values',
        () => testEnumError(
              expectedError:
                  'Exception: There is no value defined for property name for the enum value MALE in model Gender. Either make this property optional or give it a value',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  description: this is an enum
  properties:
    name: String
  values:
    MALE:
      description: this is a enum of male
      properties:
    FEMALE:
      description: this is a enum of female
      properties:
""",
            ));

    test(
        'Test enum with incorrect type bool',
        () => testEnumError(
              expectedError: 'Exception: Model: Gender, Property isMale is of type bool but the corresponding value on enum value MALE is not, make sure they have the same type',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  description: this is an enum
  properties:
    isMale: bool
  values:
    MALE:
      description: this is a enum of male
      properties:
        isMale: 1
    FEMALE:
      description: this is a enum of female
      properties:
        isMale: 1
""",
            ));

    test(
        'Test enum with incorrect type integer',
        () => testEnumError(
              expectedError: 'Exception: Model: Gender, Property isMale is of type int but the corresponding value on enum value MALE is not, make sure they have the same type',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  description: this is an enum
  properties:
    isMale: int
  values:
    MALE:
      description: this is a enum of male
      properties:
        isMale: hello
    FEMALE:
      description: this is a enum of female
      properties:
        isMale: hello
""",
            ));

    test(
        'Test enum with incorrect type double',
        () => testEnumError(
              expectedError: 'Exception: Model: Gender, Property isMale is of type double but the corresponding value on enum value MALE is not, make sure they have the same type',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  description: this is an enum
  properties:
    isMale: double
  values:
    MALE:
      description: this is a enum of male
      properties:
        isMale: hello
    FEMALE:
      description: this is a enum of female
      properties:
        isMale: hello
""",
            ));

    test(
        'item_type not supported anymore',
        () => testEnumError(
              expectedError: 'Exception: item_type is removed, follow the migration to version 7.0.0',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  item_type: double
  values:
    MALE:
    FEMALE:
""",
            ));
    test(
        'generate_map not supported anymore',
        () => testEnumError(
              expectedError: 'Exception: generate_map is removed, follow the migration to version 7.0.0',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  generate_map: true
  values:
    MALE:
    FEMALE:
""",
            ));
    test(
        'generate_extensions not supported anymore',
        () => testEnumError(
              expectedError: 'Exception: generate_extensions is removed, follow the migration to version 7.0.0',
              enumYml: """
Gender:
  path: user/person/
  type: enum
  generate_extensions: true
  values:
    MALE:
    FEMALE:
""",
            ));
  });
}