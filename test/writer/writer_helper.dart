import 'dart:io';

import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';

class WriterHelper {
  WriterHelper._();

  static ({
    String expected,
    YmlGeneratorConfig config,
    PubspecConfig pubspecConfig,
  }) prepareWriterTest({
    required String path,
    String? pubspecPath,
  }) {
    final file = File('$path/output.txt');
    final pubspecFile = File('${pubspecPath ?? path}/pubspec.txt');
    final configFile = File('$path/config.txt');
    final expected = file.readAsStringSync();
    final pubspecContent = pubspecFile.readAsStringSync();
    final configContent = configFile.readAsStringSync();
    final pubspecConfig = PubspecConfig(pubspecContent);
    final ymlConfig = YmlGeneratorConfig(pubspecConfig, configContent, '');

    return (
      expected: expected,
      config: ymlConfig,
      pubspecConfig: pubspecConfig,
    );
  }
}
