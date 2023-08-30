import 'dart:io';

import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/writer/object_model_writer.dart';
import 'package:test/test.dart';

void main() {
  void testObjectModelWriter(String path) {
    final file = File('$path/output.txt');
    final pubspecFile = File('$path/pubspec.txt');
    final configFile = File('$path/config.txt');
    final expected = file.readAsStringSync();
    final pubspecContent = pubspecFile.readAsStringSync();
    final configContent = configFile.readAsStringSync();
    final pubspecConfig = PubspecConfig(pubspecContent);
    final ymlConfig = YmlGeneratorConfig(pubspecConfig, configContent, '');
    final jsonModel = ymlConfig.models.first;
    if (jsonModel is! ObjectModel) {
      throw Exception('The first model in the config file must be an object model and will be validated. The model is ${ymlConfig.models.first.runtimeType}');
    }

    final generateActual = ObjectModelWriter(pubspecConfig, jsonModel, ymlConfig).write;
    if (expected.startsWith('Exception')) {
      expect(generateActual, throwsA(isA<Exception>()));
    } else {
      expect(generateActual(), expected);
    }
  }

  group('ObjectModelWriter', () {
    final directory = Directory('test/writer/object_model_writer');
    final folders = directory.listSync();
    for (final folder in folders) {
      if (folder is Directory) {
        test('Folder ${folder.path}', () {
          print('Testing folder ${folder.path}');
          testObjectModelWriter(folder.path);
        });
      }
    }
  });
}
