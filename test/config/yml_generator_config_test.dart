import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:test/test.dart';

import 'config_test_helper.dart';

void main() {
  group('YmlGeneratorConfig', () {
    group('Object', () {
      test('Normal object', () {
        final pubspecConfig =
            PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig,
            ConfigTestHelper.getYmlGeneratorConfig('object-normal'));
        expect(ymlConfig.models.length, 1);
        expect(ymlConfig.models.first is ObjectModel, true);
        final objectModel =
            ymlConfig.models.first as ObjectModel; // ignore: avoid_as
        expect(objectModel.path, null);
        expect(objectModel.baseDirectory, 'model');
        expect(objectModel.fileName, 'person');
        expect(objectModel.fields.length, 1);
        expect(objectModel.converters.isEmpty, true);
      });

      test('Normal object with multiple fields', () {
        final pubspecConfig =
            PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig,
            ConfigTestHelper.getYmlGeneratorConfig('object-multiple-fields'));
        expect(ymlConfig.models.length, 1);
        expect(ymlConfig.models.first is ObjectModel, true);
        final objectModel =
            ymlConfig.models.first as ObjectModel; // ignore: avoid_as
        expect(objectModel.path, null);
        expect(objectModel.baseDirectory, 'model');
        expect(objectModel.fileName, 'person');
        expect(objectModel.fields.length, 3);
        expect(objectModel.converters.isEmpty, true);
      });

      test('Normal object with baseDirectory', () {
        final pubspecConfig =
            PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig,
            ConfigTestHelper.getYmlGeneratorConfig('object-base-dir'));
        expect(ymlConfig.models.length, 1);
        expect(ymlConfig.models.first is ObjectModel, true);
        final objectModel =
            ymlConfig.models.first as ObjectModel; // ignore: avoid_as
        expect(objectModel.path, null);
        expect(objectModel.baseDirectory, 'custom_base_dir');
        expect(objectModel.fileName, 'person');
        expect(objectModel.fields.length, 3);
        expect(objectModel.converters.isEmpty, true);
      });

      test('Normal object with all types', () {
        final pubspecConfig =
            PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        final ymlConfig = YmlGeneratorConfig(pubspecConfig,
            ConfigTestHelper.getYmlGeneratorConfig('object-all-types'));
        expect(ymlConfig.models.length, 2);
        expect(ymlConfig.models.first is ObjectModel, true);
        final objectModel =
            ymlConfig.models.first as ObjectModel; // ignore: avoid_as
        expect(objectModel.path, null);
        expect(objectModel.baseDirectory, 'model');
        expect(objectModel.fileName, 'person');
        expect(objectModel.fields.length, 25);
        expect(objectModel.converters.isEmpty, true);
      });

      test('Error property is no object', () {
        final pubspecConfig =
            PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(pubspecConfig,
              ConfigTestHelper.getYmlGeneratorConfig('object-error-no-object'));
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: firstName should be an object');
      });

      test('Error missing type', () {
        final pubspecConfig =
            PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(
              pubspecConfig,
              ConfigTestHelper.getYmlGeneratorConfig(
                  'object-error-missing-type'));
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage, 'Exception: firstName has no defined type');
      });

      test('Error no properties', () {
        final pubspecConfig =
            PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
        var hasError = false;
        var errorMessage = '';
        try {
          YmlGeneratorConfig(
              pubspecConfig,
              ConfigTestHelper.getYmlGeneratorConfig(
                  'object-error-no-properties'));
        } catch (e) {
          hasError = true;
          errorMessage = e.toString();
        }
        expect(hasError, true);
        expect(errorMessage,
            'Exception: Properties can not be null. model: Person');
      });
    });
  });
}
