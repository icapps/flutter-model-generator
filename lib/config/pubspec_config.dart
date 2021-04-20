import 'dart:io';

import 'package:yaml/yaml.dart';

class PubspecConfig {
  static final _DEFAULT_CONFIG_PATH = // ignore: non_constant_identifier_names
      'model_generator${Platform.pathSeparator}config.yaml';
  static const _DEFAULT_BASE_DIRECTORY = 'model';

  late String projectName;
  late String baseDirectory;
  late bool useFvm;
  late bool generateForGenerics;
  late String configPath;
  late bool equalsHashCode;
  final extraImports = <String>[];
  final extraAnnotations = <String>[];

  PubspecConfig(String pubspecContent) {
    final doc = loadYaml(pubspecContent);
    if (!(doc is YamlMap)) {
      throw Exception('Could not parse the pubspec.yaml');
    }
    final projectName = doc['name'];

    if (projectName == null || projectName.isEmpty) {
      throw Exception(
          'Could not parse the pubspec.yaml, project name not found');
    }

    this.projectName = projectName;
    final config = doc['model_generator'];
    if (config == null) {
      baseDirectory = _DEFAULT_BASE_DIRECTORY;
      generateForGenerics = false;
      useFvm = false;
      configPath = _DEFAULT_CONFIG_PATH;
      equalsHashCode = false;
      return;
    }

    baseDirectory = config['base_directory'] ?? _DEFAULT_BASE_DIRECTORY;
    useFvm = (config['use_fvm'] ?? false) == true;
    generateForGenerics = (config['generate_for_generics'] ?? false) == true;
    configPath = config['config_path'] ?? _DEFAULT_CONFIG_PATH;
    equalsHashCode = (config['equals_and_hash_code'] ?? false) == true;

    final extraImports = config['extra_imports'];
    if (extraImports != null) {
      extraImports
          .forEach((element) => this.extraImports.add(element.toString()));
    }
    final extraAnnotations = config['extra_annotations'];
    if (extraAnnotations != null) {
      extraAnnotations
          .forEach((element) => this.extraAnnotations.add(element.toString()));
    }
  }
}
