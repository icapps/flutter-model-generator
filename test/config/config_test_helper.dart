import 'dart:io';

class ConfigTestHelper {
  static String getPubspecConfig(String resultFileName) {
    print(Directory.current);
    final file = File('test/config/pubspec_config/$resultFileName.txt');
    return file.readAsStringSync();
  }

  static String getYmlGeneratorConfig(String resultFileName) {
    print(Directory.current);
    final file = File('test/config/yml_generator_config/$resultFileName.txt');
    return file.readAsStringSync();
  }
}
