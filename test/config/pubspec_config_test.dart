import 'dart:io';

import 'package:model_generator/config/pubspec_config.dart';
import 'package:test/test.dart';

void main() {
  group('Default', () {
    test('Normal pubspec.yaml', () {
      const yaml = r'''
name: model_generator
description: Dart tool to automaticly generate models from a yml file to speed up your development flow.
version: 3.2.0
homepage: https://github.com/icapps/flutter-model-generator

environment:
  sdk: ">=2.1.0 <3.0.0"

dependencies:
  path: ^1.7.0
  yaml: ^2.2.1
  meta: ^1.2.3
  args: ^1.6.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  test: ^1.15.4
      ''';
      final pubspecConfig = PubspecConfig(yaml);
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Yaml with only required fields', () {
      const yaml = r'''
name: model_generator_example
      ''';
      final pubspecConfig = PubspecConfig(yaml);
      expect(pubspecConfig.projectName, 'model_generator_example');
    });
  });

  group('Custom params', () {
    test('Normal pubspec.yaml', () {
      const yaml = r'''
name: model_generator
model_generator:
      ''';
      final pubspecConfig = PubspecConfig(yaml);
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Default values pubspec.yaml', () {
      const yaml = r'''
name: model_generator
      ''';
      final pubspecConfig = PubspecConfig(yaml);
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Custom base_directory', () {
      const yaml = r'''
name: model_generator
model_generator:
  base_directory: custom_models
      ''';
      final pubspecConfig = PubspecConfig(yaml);
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'custom_models');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Custom useFvm', () {
      const yaml = r'''
name: model_generator
model_generator:
  use_fvm: true
      ''';
      final pubspecConfig = PubspecConfig(yaml);
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, true);
      expect(pubspecConfig.configPath,
          'model_generator${Platform.pathSeparator}config.yaml');
    });

    test('Custom configPath', () {
      const yaml = r'''
name: model_generator
model_generator:
  config_path: custom_config.yaml
      ''';
      final pubspecConfig = PubspecConfig(yaml);
      expect(pubspecConfig.projectName, 'model_generator');
      expect(pubspecConfig.baseDirectory, 'model');
      expect(pubspecConfig.useFvm, false);
      expect(pubspecConfig.configPath, 'custom_config.yaml');
    });
  });

  group('Error', () {
    test('No name pubspec.yaml', () {
      const yaml = r'''
      ''';
      var hasError = false;
      var errorMessage = '';
      try {
        PubspecConfig(yaml);
      } catch (e) {
        hasError = e is Exception;
        errorMessage = e.toString();
      }
      expect(hasError, true);
      expect(errorMessage, 'Exception: Could not parse the pubspec.yaml');
    });
    test('No name but arg added pubspec.yaml', () {
      const yaml = r'''
name: 
      ''';
      var hasError = false;
      var errorMessage = '';
      try {
        PubspecConfig(yaml);
      } catch (e) {
        hasError = e is Exception;
        errorMessage = e.toString();
      }
      expect(hasError, true);
      expect(errorMessage,
          'Exception: Could not parse the pubspec.yaml, project name not found');
    });
  });
}
