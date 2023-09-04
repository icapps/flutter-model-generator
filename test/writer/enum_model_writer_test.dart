import 'dart:io';

import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/writer/enum_model_writer.dart';
import 'package:test/test.dart';

import 'writer_helper.dart';

void main() {
  void testEnumModelWriter(String path) {
    final result = WriterHelper.prepareYmlConfig(
      path: path,
      pubspecPath: 'test/writer/enum_model_writer',
    );
    final jsonModel = result.config.models.first;
    if (jsonModel is! EnumModel) {
      throw Exception('The first model in the config file must be an object model and will be validated. The model is ${jsonModel.runtimeType}');
    }

    final generateActual = EnumModelWriter(jsonModel).write;
    if (result.expected.startsWith('Exception')) {
      expect(generateActual, throwsA(isA<Exception>()));
    } else {
      expect(generateActual(), result.expected);
    }
  }

  group('EnumModelWriter test', () {
    final directory = Directory('test/writer/enum_model_writer');
    final folders = directory.listSync();
    for (final folder in folders) {
      if (folder is Directory) {
        test('Folder ${folder.path}', () {
          print('Testing folder ${folder.path}');
          testEnumModelWriter(folder.path);
        });
      }
    }
  });
}
