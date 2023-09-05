import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/item_type/object_type.dart';
import 'package:model_generator/model/model/custom_model.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:test/test.dart';

import 'config_test_helper.dart';

void main() {
  group('YmlGeneratorConfig', () {
    group('Empty', () {
      test('Behaviour with empty file', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, '', '');
        expect(ymlConfig.models.isEmpty, true);
      });
    });
    group('Object', () {
      test('Normal object', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-normal'), '');
        ymlConfig.checkIfTypesAvailable();
        expect(ymlConfig.models.length, 1);
        expect(ymlConfig.models.first is ObjectModel, true);
        final objectModel = ymlConfig.models.first as ObjectModel; // ignore: avoid_as
        expect(objectModel.path, null);
        expect(objectModel.baseDirectory, 'model');
        expect(objectModel.fileName, 'person');
        expect(objectModel.fields.length, 1);
        expect(objectModel.converters.isEmpty, true);
      });

      test('Normal object with multiple fields', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-multiple-fields'), '');
        ymlConfig.checkIfTypesAvailable();
        expect(ymlConfig.models.length, 1);
        expect(ymlConfig.models.first is ObjectModel, true);
        final objectModel = ymlConfig.models.first as ObjectModel; // ignore: avoid_as
        expect(objectModel.path, null);
        expect(objectModel.baseDirectory, 'model');
        expect(objectModel.fileName, 'person');
        expect(objectModel.fields.length, 3);
        expect(objectModel.converters.isEmpty, true);
      });

      test('Normal object with baseDirectory', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-base-dir'), '');
        ymlConfig.checkIfTypesAvailable();
        expect(ymlConfig.models.length, 1);
        expect(ymlConfig.models.first is ObjectModel, true);
        final objectModel = ymlConfig.models.first as ObjectModel; // ignore: avoid_as
        expect(objectModel.path, null);
        expect(objectModel.baseDirectory, 'custom_base_dir');
        expect(objectModel.fileName, 'person');
        expect(objectModel.fields.length, 3);
        expect(objectModel.converters.isEmpty, true);
      });

      test('Normal object with all types', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-all-types'), '');
        ymlConfig.checkIfTypesAvailable();
        expect(ymlConfig.models.length, 2);
        expect(ymlConfig.models.first is ObjectModel, true);
        final objectModel = ymlConfig.models.first as ObjectModel; // ignore: avoid_as
        expect(objectModel.path, null);
        expect(objectModel.baseDirectory, 'model');
        expect(objectModel.fileName, 'person');
        expect(objectModel.fields.length, 25);
        expect(objectModel.converters.isEmpty, true);
      });

      test('Error property is no object', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-error-no-object'), '').checkIfTypesAvailable();
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: firstName should be an object');
      });

      test('Error missing type', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-error-missing-type'), '').checkIfTypesAvailable();
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: firstName has no defined type');
      });

      test('Error no properties', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-error-no-properties'), '').checkIfTypesAvailable();
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: Properties can not be null. model: Person');
      });
    });
    group('Custom', () {
      test('Custom object', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('custom-normal'), '');
        ymlConfig.checkIfTypesAvailable();
        expect(ymlConfig.models.length, 2);
        expect(ymlConfig.models.first is ObjectModel, true);
        expect(ymlConfig.models.last is CustomModel, true);
      });
    });
    group('Enum', () {
      test('Normal Enum', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-normal'), '');
        ymlConfig.checkIfTypesAvailable();
        expect(ymlConfig.models.length, 3);
        expect(ymlConfig.models.first is ObjectModel, true);
        expect(ymlConfig.models[1] is EnumModel, true);
        expect(ymlConfig.models.last is EnumModel, true);
        expect(pubspecConfig.uppercaseEnums, true);
        final enumModel = ymlConfig.models[1] as EnumModel; // ignore: avoid_as
        final enumModel2 = ymlConfig.models[2] as EnumModel; // ignore: avoid_as
        expect(enumModel.fields, isNotNull);
        expect(enumModel.fields.length, 4);
        expect(enumModel.keyProperty, 'value');
        expect(enumModel.fields[0].name, 'MALE');
        expect(enumModel.fields[0].serializedName, 'MALE');
        expect(enumModel.fields[0].enumProperties[0].value, 'male');
        expect(enumModel.fields[0].enumProperties[0].name, 'value');
        expect(enumModel.fields[1].name, 'FEMALE');
        expect(enumModel.fields[1].serializedName, 'FEMALE');
        expect(enumModel.fields[1].enumProperties[0].value, 'femAle');
        expect(enumModel.fields[1].enumProperties[0].name, 'value');
        expect(enumModel.fields[2].name, 'OTHER');
        expect(enumModel.fields[2].serializedName, 'other');
        expect(enumModel.fields[2].enumProperties[0].value, 'other');
        expect(enumModel.fields[2].enumProperties[0].name, 'value');
        expect(enumModel.fields[3].name, 'X');
        expect(enumModel.fields[3].serializedName, 'X');
        expect(enumModel.fields[3].enumProperties[0].value, 'x');
        expect(enumModel.fields[3].enumProperties[0].name, 'value');

        expect(enumModel2.fields, isNotNull);
        expect(enumModel2.fields.length, 4);
        expect(enumModel.keyProperty, 'value');
        expect(enumModel2.fields[0].name, 'male');
        expect(enumModel2.fields[0].serializedName, 'male');
        expect(enumModel.fields[0].enumProperties[0].value, 'male');
        expect(enumModel.fields[0].enumProperties[0].name, 'value');
        expect(enumModel2.fields[1].name, 'female');
        expect(enumModel2.fields[1].serializedName, 'female');
        expect(enumModel.fields[1].enumProperties[0].value, 'femAle');
        expect(enumModel.fields[1].enumProperties[0].name, 'value');
        expect(enumModel2.fields[2].name, 'other');
        expect(enumModel2.fields[2].serializedName, 'other');
        expect(enumModel.fields[2].enumProperties[0].value, 'other');
        expect(enumModel.fields[2].enumProperties[0].name, 'value');
        expect(enumModel2.fields[3].name, 'X');
        expect(enumModel2.fields[3].serializedName, 'X');
        expect(enumModel.fields[3].enumProperties[0].value, 'x');
        expect(enumModel.fields[3].enumProperties[0].name, 'value');
      });

      test('Error Enum no properties map', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-error-no-object'), '').checkIfTypesAvailable();
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: MALE should be an object');
      });

      test('Error Enum', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-error-no-properties-map'), '').checkIfTypesAvailable();
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: Properties should be a map, right now you are using a String. model: Gender');
      });
    });

    test('Error with not registered object', () {
      final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
      var hasError = false;
      var errorMessage = '';
      try {
        YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('error-not-registered'), '').checkIfTypesAvailable();
      } catch (e) {
        hasError = true;
        errorMessage = e.toString();
      }
      expect(hasError, true);
      expect(errorMessage, 'Exception: Could not generate all models. `Address` is not added to the config file');
    });

    test('Error with not registered extend', () {
      final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
      var hasError = false;
      var errorMessage = '';
      try {
        YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('error-not-registered-extend'), '').checkIfTypesAvailable();
      } catch (e) {
        hasError = true;
        errorMessage = e.toString();
      }
      expect(hasError, true);
      expect(errorMessage, 'Exception: Could not generate all models. `Address` is not added to the config file, but is extended. These types are known: Person');
    });

    group('Getters', () {
      test('Get path with invalid model', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        final config = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-normal'), '')..checkIfTypesAvailable();
        try {
          config.getPathsForName(pubspecConfig, 'TESTING');
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: getPathForName is null: because `TESTING` was not added to the config file');
      });
      test('Get paths with generic model', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final config = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('generics-normal'), '');
        config.checkIfTypesAvailable();
        expect(config.getPathsForName(pubspecConfig, 'List<Person>').toList(), ['model']);
      });
      test('Get paths with dart:core model', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final config = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('custom-dart-core'), '');
        config.checkIfTypesAvailable();
        expect(config.getPathsForName(pubspecConfig, 'Address').toList(), []);
      });
      test('Get path with invalid model', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        final config = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-normal'), '');
        config.checkIfTypesAvailable();
        try {
          config.getModelByName(ObjectType('TESTING'));
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: getModelByName is null: because `TESTING` was not added to the config file');
      });
    });
    group('Config merging tests', () {
      test('Test merge happy path', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig1 = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-normal'), '');
        final ymlConfig2 = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-normal'), '');
        final merged = YmlGeneratorConfig.merge([ymlConfig1, ymlConfig2], 'dirName');
        expect(merged.models.length, 4);
        expect(merged.models.any((element) => element.name == 'Person'), true);
        expect(merged.models.any((element) => element.name == 'User'), true);
        expect(merged.models.any((element) => element.name == 'Gender'), true);
        expect(merged.models.any((element) => element.name == 'Vehicles'), true);
        merged.checkIfTypesAvailable();
      });
      test('Test merge reference other file', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig1 = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-reference-other'), '');
        final ymlConfig2 = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-normal'), '');
        final merged = YmlGeneratorConfig.merge([ymlConfig1, ymlConfig2], 'dirName');
        expect(merged.models.length, 4);
        expect(merged.models.any((element) => element.name == 'Person'), true);
        expect(merged.models.any((element) => element.name == 'User'), true);
        expect(merged.models.any((element) => element.name == 'Gender'), true);
        expect(merged.models.any((element) => element.name == 'Vehicles'), true);
        merged.checkIfTypesAvailable();
      });
      test('Test merge reference not found', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig1 = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-reference-other-unknown'), '');
        final ymlConfig2 = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-normal'), '');
        final merged = YmlGeneratorConfig.merge([ymlConfig1, ymlConfig2], 'dirName');
        expect(() => merged.checkIfTypesAvailable(), throwsA(isA<Exception>()));
      });
      test('Test duplicate models', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig1 = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-reference-other-unknown'), '');
        final ymlConfig2 = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-reference-other'), '');
        expect(() => YmlGeneratorConfig.merge([ymlConfig1, ymlConfig2], 'dirName'), throwsA(isA<Exception>()));
      });
    });
  });
}
