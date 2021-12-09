import 'dart:io';

import 'package:model_generator/config/pubspec_config.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'config_test_helper.dart';

void main() {
  group('Default', () {
    test('Normal pubspec.yaml', () {
      final pubspecConfig =
          PubspecConfig(ConfigTestHelper.getPubspecConfig('normal'));
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Yaml with only required fields', () {
      final pubspecConfig = PubspecConfig(
          ConfigTestHelper.getPubspecConfig('only-required-fields'));
      expect(pubspecConfig.projectName, 'model_generator_example');
    });
  });

  group('Custom params', () {
    test('Default values pubspec.yaml', () {
      final pubspecConfig = PubspecConfig(
          ConfigTestHelper.getPubspecConfig('custom-params-default'));
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Normal pubspec.yaml', () {
      final pubspecConfig = PubspecConfig(
          ConfigTestHelper.getPubspecConfig('custom-params-nothing'));
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Custom base_directory', () {
      final pubspecConfig = PubspecConfig(
          ConfigTestHelper.getPubspecConfig('custom-params-base-dir'));
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'custom_models');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Custom useFvm', () {
      final pubspecConfig =
          PubspecConfig(ConfigTestHelper.getPubspecConfig('custom-params-fvm'));
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, true);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Custom configPath', () {
      final pubspecConfig = PubspecConfig(ConfigTestHelper.getPubspecConfig(
          'custom-params-custom-config-path'));
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath, 'custom_config.yaml');
    });
  });

  group('Error', () {
    test('No name pubspec.yaml', () {
      var hasError = false;
      var errorMessage = '';
      try {
        PubspecConfig(ConfigTestHelper.getPubspecConfig('error-empty-pubspec'));
      } catch (e) {
        hasError = e is Exception;
        errorMessage = e.toString();
      }
      expect(hasError, true);
      expect(errorMessage, 'Exception: Could not parse the pubspec.yaml');
    });
    test('No name but arg added pubspec.yaml', () {
      var hasError = false;
      var errorMessage = '';
      try {
        PubspecConfig(ConfigTestHelper.getPubspecConfig('error-no-name'));
      } catch (e) {
        hasError = e is Exception;
        errorMessage = e.toString();
      }
      expect(hasError, true);
      expect(errorMessage,
          'Exception: Could not parse the pubspec.yaml, project name not found');
    });
    test('Test parse any version', () {
      expect(
          PubspecConfig.parseLanguageVersion(YamlMap.wrap({
            'environment': {'sdk': 'any'}
          })),
          null);
    });
    test('Test parse fixed version', () {
      expect(
          PubspecConfig.parseLanguageVersion(YamlMap.wrap({
            'environment': {'sdk': '2.14.0'}
          }))!
              .toString(),
          '2.14.0');
    });
    test('Test parse max version', () {
      expect(
          PubspecConfig.parseLanguageVersion(YamlMap.wrap({
            'environment': {'sdk': '<2.14.0'}
          })),
          null);
    });
    test('Test parse min and max version', () {
      expect(
          PubspecConfig.parseLanguageVersion(YamlMap.wrap({
            'environment': {'sdk': '>=2.14.0 <3.0.0'}
          }))!
              .toString(),
          '2.14.0');
    });
  });
}
