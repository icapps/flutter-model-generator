import 'dart:io';

import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/writer/object_model_writer.dart';
import 'package:test/test.dart';

import 'writer_helper.dart';

void main() {
  void testObjectModelWriter(String path) {
    final result = WriterHelper.prepareWriterTest(path: path);
    final jsonModel = result.config.models.first;
    if (jsonModel is! ObjectModel) {
      throw Exception(
          'The first model in the config file must be an object model and will be validated. The model is ${jsonModel.runtimeType}');
    }

    final generateActual =
        ObjectModelWriter(result.pubspecConfig, jsonModel, result.config).write;
    if (result.expected.startsWith('Exception')) {
      expect(generateActual, throwsA(isA<Exception>()));
    } else {
      expect(generateActual(), result.expected);
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
