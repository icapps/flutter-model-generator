import 'dart:io';

import 'package:yaml/yaml.dart';

class PubspecConfig {
  static final _DEFAULT_CONFIG_PATH = // ignore: non_constant_identifier_names
      'model_generator${Platform.pathSeparator}config.yaml';
  static const _DEFAULT_BASE_DIRECTORY = 'model';

  String projectName;
  String baseDirectory;
  bool useFvm;
  String configPath;

  PubspecConfig(String pubspecContent) {
    final doc = loadYaml(pubspecContent);
    projectName = doc['name'];

    if (projectName == null || projectName.isEmpty) {
      throw Exception(
          'Could not parse the pubspec.yaml, project name not found');
    }

    final config = doc['model_generator'];
    if (config == null) {
      baseDirectory = _DEFAULT_BASE_DIRECTORY;
      useFvm = false;
      configPath = _DEFAULT_CONFIG_PATH;
      return;
    }

    baseDirectory = config['base_directory'] ?? _DEFAULT_BASE_DIRECTORY;
    useFvm = config['use_fvm'] == 'true';
    configPath = config['config_path'] ?? _DEFAULT_CONFIG_PATH;
  }
}
