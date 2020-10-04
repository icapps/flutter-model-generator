import 'package:yaml/yaml.dart';

class PubspecConfig {
  String projectName;
  String baseDirectory;

  PubspecConfig(String pubspecContent) {
    final doc = loadYaml(pubspecContent);
    projectName = doc['name'];

    if (projectName == null || projectName.isEmpty) {
      throw Exception(
          'Could not parse the pubspec.yaml, project name not found');
    }

    final config = doc['model_generator'];
    if (config == null) {
      baseDirectory = 'model';
      return;
    }

    baseDirectory = config['base_directory'] ?? 'model';
  }
}
