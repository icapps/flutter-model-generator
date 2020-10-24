import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/writer/enum_model_writer.dart';
import 'package:model_generator/writer/object_model_writer.dart';

class WriterTestHelper {
  static testEnumModelWriter(EnumModel model, String resultFileName) {
    print(Directory.current);
    final file = File('writer/enum_model_writer/output/$resultFileName.txt');
    final output = file.readAsStringSync();
    final actual = EnumModelWriter(model).write();
    // print(actual);
    expect(actual, output);
  }

  static testObjectModelWriter(ObjectModel model, String resultFileName) {
    print(Directory.current);
    final file = File('writer/object_model_writer/output/$resultFileName.txt');
    final pubspecFile =
        File('writer/object_model_writer/input/${resultFileName}_pubspec.txt');
    final configFile =
        File('writer/object_model_writer/input/${resultFileName}_config.txt');
    final output = file.readAsStringSync();
    final pubspecContent = pubspecFile.readAsStringSync();
    final configContent = configFile.readAsStringSync();
    final pubspecConfig = PubspecConfig(pubspecContent);
    final ymlConfig = YmlGeneratorConfig(pubspecConfig, configContent);
    final actual = ObjectModelWriter(pubspecConfig, model, ymlConfig).write();
    // print(actual);
    expect(actual, output);
  }
}
