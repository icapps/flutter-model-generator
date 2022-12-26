import 'dart:io';

import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/writer/drift_model_writer.dart';
import 'package:model_generator/writer/enum_model_writer.dart';
import 'package:model_generator/writer/object_model_writer.dart';
import 'package:test/test.dart';

class WriterTestHelper {
  static testEnumModelWriter(EnumModel model, String resultFileName) {
    print(Directory.current);
    final file = File('test/writer/enum_model_writer/$resultFileName.txt');
    final output = file.readAsStringSync();
    final actual = EnumModelWriter(model).write();
    // print(actual);
    expect(actual, output);
  }

  static testObjectModelWriter(
      ObjectModel model, List<Field> extendsFields, String resultFileName) {
    print(Directory.current);
    final file =
        File('test/writer/object_model_writer/$resultFileName/output.txt');
    final pubspecFile =
        File('test/writer/object_model_writer/$resultFileName/pubspec.txt');
    final configFile =
        File('test/writer/object_model_writer/$resultFileName/config.txt');
    final output = file.readAsStringSync();
    final pubspecContent = pubspecFile.readAsStringSync();
    final configContent = configFile.readAsStringSync();
    final pubspecConfig = PubspecConfig(pubspecContent);
    final ymlConfig = YmlGeneratorConfig(pubspecConfig, configContent, '');
    final actual =
        ObjectModelWriter(pubspecConfig, model, extendsFields, ymlConfig)
            .write();
    // print(actual);
    expect(actual, output);
  }

  static testDriftModelWriter(ObjectModel model, List<Field> extendsFields,
      List<Field> enumFields, String resultFileName) {
    print(Directory.current);
    final file =
        File('test/writer/drift_model_writer/$resultFileName/output.txt');
    final pubspecFile =
        File('test/writer/drift_model_writer/$resultFileName/pubspec.txt');
    final configFile =
        File('test/writer/drift_model_writer/$resultFileName/config.txt');
    final output = file.readAsStringSync();
    final pubspecContent = pubspecFile.readAsStringSync();
    final configContent = configFile.readAsStringSync();
    final pubspecConfig = PubspecConfig(pubspecContent);
    final ymlConfig = YmlGeneratorConfig(pubspecConfig, configContent, '');
    final actual = DriftModelWriter(
            pubspecConfig, model, extendsFields, enumFields, ymlConfig)
        .write();
    // print(actual);
    expect(actual, output);
  }
}
