import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/model/custom_model.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/model/model/json_converter_model.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/run_process/run_process.dart';
import 'package:model_generator/writer/enum_model_writer.dart';
import 'package:model_generator/writer/object_model_writer.dart';
import 'package:path/path.dart';

class ModelGenerator {
  ModelGenerator._();

  static void generate(ArgResults results) async {
    final pubspecYaml = File(join(Directory.current.path, 'pubspec.yaml'));
    if (!pubspecYaml.existsSync()) {
      throw Exception(
          'This program should be run from the root of a flutter/dart project');
    }
    final pubspecContent = pubspecYaml.readAsStringSync();
    final pubspecConfig = PubspecConfig(pubspecContent);

    final configPath = results['path'] ?? pubspecConfig.configPath;
    String absolutePath;
    if (isAbsolute(configPath)) {
      absolutePath = configPath;
    } else {
      absolutePath = join(Directory.current.path, configPath);
    }
    final FileSystemEntity configEntity;
    switch (FileSystemEntity.typeSync(absolutePath)) {
      case FileSystemEntityType.directory:
        configEntity = Directory(absolutePath);
        break;
      case FileSystemEntityType.file:
      default:
        configEntity = File(absolutePath);
        break;
    }

    if (!configEntity.existsSync()) {
      throw Exception(
          'This program requires a config file/dir. `$configPath` does not exist');
    }
    final YmlGeneratorConfig modelGeneratorConfig;
    if (configEntity is Directory) {
      modelGeneratorConfig =
          _readConfigFilesInDirectory(pubspecConfig, configEntity, configPath);
    } else {
      final modelGeneratorContent = (configEntity as File).readAsStringSync();
      modelGeneratorConfig =
          YmlGeneratorConfig(pubspecConfig, modelGeneratorContent, configPath);
    }
    modelGeneratorConfig.checkIfTypesAvailable();
    if (modelGeneratorConfig.models.isEmpty) {
      print('No models defined in config files, skipping generation');
    }

    _writeToFiles(pubspecConfig, modelGeneratorConfig);
    await _generateJsonGeneratedModels(useFvm: pubspecConfig.useFvm);
    print('Done!!!');
  }

  static YmlGeneratorConfig _readConfigFilesInDirectory(
      PubspecConfig config, Directory configEntity, String directoryPath) {
    final configFiles = configEntity
        .listSync(recursive: true)
        .whereType<File>()
        .where((element) =>
            extension(element.path) == '.yaml' ||
            extension(element.path) == '.yml');
    final configs = configFiles.map((e) =>
        YmlGeneratorConfig(config, e.readAsStringSync(), relative(e.path)));
    return YmlGeneratorConfig.merge(configs, directoryPath);
  }

  static void _writeToFiles(
      PubspecConfig pubspecConfig, YmlGeneratorConfig modelGeneratorConfig) {
    for (final model in modelGeneratorConfig.models) {
      final modelDirectory = Directory(join('lib', model.baseDirectory));
      if (!modelDirectory.existsSync()) {
        modelDirectory.createSync(recursive: true);
      }
      String? content;
      if (model is ObjectModel) {
        content = ObjectModelWriter(
          pubspecConfig,
          model,
          modelGeneratorConfig,
        ).write();
      } else if (model is EnumModel) {
        content = EnumModelWriter(model).write();
      } else if (model is JsonConverterModel) {
        continue;
      } else if (model is CustomModel) {
        continue;
      }
      if (content == null) {
        throw Exception(
            'content is null for ${model.name}. File a bug report on github. This is not normal. https://github.com/icapps/flutter-model-generator/issues');
      }
      File file;
      if (model.path == null) {
        file = File(join('lib', model.baseDirectory, '${model.fileName}.dart'));
      } else {
        file = File(join(
            'lib', model.baseDirectory, model.path, '${model.fileName}.dart'));
      }
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      file.writeAsStringSync(content);
    }
  }

  static Future<void> _generateJsonGeneratedModels(
      {required bool useFvm}) async {
    final arguments = [
      if (useFvm) ...[
        'fvm',
      ],
      'flutter',
      'packages',
      'pub',
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ];
    await ProcessRunner.runProcessVerbose(
      arguments.first,
      arguments.skip(1).toList(),
    );
  }
}
