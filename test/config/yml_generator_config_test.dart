import 'package:flutter_test/flutter_test.dart';
import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/item_type/object_type.dart';
import 'package:model_generator/model/model/custom_model.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/model/model/object_model.dart';

import 'config_test_helper.dart';

void main() {
  group('YmlGeneratorConfig', () {
    group('Object', () {
      test('Normal object', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-normal'));
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
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-multiple-fields'));
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
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-base-dir'));
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
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-all-types'));
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
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-error-no-object'));
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
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-error-missing-type'));
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
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-error-no-properties'));
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
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('custom-normal'));
        expect(ymlConfig.models.length, 2);
        expect(ymlConfig.models.first is ObjectModel, true);
        expect(ymlConfig.models.last is CustomModel, true);
      });
    });
    group('Enum', () {
      test('Normal Enum', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-normal'));
        expect(ymlConfig.models.length, 2);
        expect(ymlConfig.models.first is ObjectModel, true);
        expect(ymlConfig.models.last is EnumModel, true);
        final enumModel = ymlConfig.models.last as EnumModel; // ignore: avoid_as
        expect(enumModel.fields, isNotNull);
        expect(enumModel.fields!.length, 4);
        expect(enumModel.fields![0].name, 'MALE');
        expect(enumModel.fields![0].serializedName, 'MALE');
        expect(enumModel.fields![0].value, null);
        expect(enumModel.fields![1].name, 'FEMALE');
        expect(enumModel.fields![1].serializedName, 'FEMALE');
        expect(enumModel.fields![1].value, 'femAle');
        expect(enumModel.fields![2].name, 'OTHER');
        expect(enumModel.fields![2].serializedName, 'other');
        expect(enumModel.fields![2].value, null);
        expect(enumModel.fields![3].name, 'X');
        expect(enumModel.fields![3].serializedName, 'X');
        expect(enumModel.fields![3].value, null);
      });

      test('Error Enum no properties map', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-error-no-object'));
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
          YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('enum-error-no-properties-map'));
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
        YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('error-not-registered'));
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
        YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('error-not-registered-extend'));
      } catch (e) {
        hasError = true;
        errorMessage = e.toString();
      }
      expect(hasError, true);
      expect(errorMessage, 'Exception: Could not generate all models. `Address` is not added to the config file');
    });

    group('Getters', () {
      test('Get path with invalid model', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        final config = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-normal'));
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
        final config = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('generics-normal'));
        expect(config.getPathsForName(pubspecConfig, 'List<Person>').toList(), ['model']);
      });
      test('Get path with invalid model', () {
        final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        final config = YmlGeneratorConfig(pubspecConfig, ConfigTestHelper.getYmlGeneratorConfig('object-normal'));
        try {
          config.getModelByName(ObjectType('TESTING'));
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: getModelByname is null: because `TESTING` was not added to the config file');
      });
    });
  });
}
