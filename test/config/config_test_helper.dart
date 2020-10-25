import 'dart:io';

class ConfigTestHelper {
  static String getPubspecConfig(String resultFileName) {
    print(Directory.current);
    final file = File('config/pubspec_config/$resultFileName.txt');
    return file.readAsStringSync();
  }

  static String getYmlGeneratorConfig(String resultFileName) {
    print(Directory.current);
    final file = File('config/yml_generator_config/$resultFileName.txt');
    return file.readAsStringSync();
  }
}
