import 'dart:io';

import 'package:path/path.dart';

import 'src/config/pubspec_config.dart';
import 'src/config/yml_generator_config.dart';
import 'src/model/model/custom_model.dart';
import 'src/model/model/enum_model.dart';
import 'src/model/object_model.dart';
import 'src/writer/enum_model_writer.dart';
import 'src/writer/object_model_writer.dart';

Future<void> main(List<String> args) async {
  final pubspecYaml = File(join(Directory.current.path, 'pubspec.yaml'));
  if (!pubspecYaml.existsSync()) {
    throw Exception(
        'This program should be run from the root of a flutter/dart project');
  }
  final pubspecContent = pubspecYaml.readAsStringSync();
  final pubspecConfig = PubspecConfig(pubspecContent);

  final configFile =
      File(join(Directory.current.path, 'model_generator', 'config.yaml'));
  if (!configFile.existsSync()) {
    throw Exception(
        'This program requires a config file. `model_generator/config.yaml`');
  }
  final modelGeneratorContent = configFile.readAsStringSync();
  final modelGeneratorConfig = YmlGeneratorConfig(modelGeneratorContent);

  writeToFiles(pubspecConfig, modelGeneratorConfig);
  await generateJsonGeneratedModels();
  print('Done!!!');
}

void writeToFiles(
    PubspecConfig pubspecConfig, YmlGeneratorConfig modelGeneratorConfig) {
  modelGeneratorConfig.models.forEach((model) {
    final modelDirectory = Directory(join('lib', model.modelDirectory));
    if (!modelDirectory.existsSync()) {
      modelDirectory.createSync(recursive: true);
    }

    String content;
    if (model is ObjectModel) {
      content = ObjectModelWriter(pubspecConfig.projectName, model).write();
    } else if (model is EnumModel) {
      content = EnumModelWriter(pubspecConfig.projectName, model).write();
    }
    if (model is! CustomModel && content == null) {
      throw Exception(
          'content is null for ${model.name}. File a bug report on github. This is not normal. https://github.com/icapps/flutter-model-generator/issues');
    }
    File file;
    if (model.path == null) {
      file = File(join('lib', model.modelDirectory, '${model.fileName}.dart'));
    } else {
      file = File(join('lib', model.modelDirectory, model.path, '${model.fileName}.dart'));
    }
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    if (model is! CustomModel) {
      file.writeAsStringSync(content);
    }
  });
}

/// run `flutter packages pub run build_runner build --delete-conflicting-outputs`
Future<void> generateJsonGeneratedModels() async {
  final result = Process.runSync('flutter', [
    'packages',
    'pub',
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);
  if (result.exitCode == 0) {
    print('Succesfully generated the jsonSerializable generated files');
    print('');
  } else {
    print(
        'Failed to run `flutter packages pub run build_runner build --delete-conflicting-outputs`');
  }
}
