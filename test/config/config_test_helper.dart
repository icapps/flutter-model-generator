import 'dart:io';

class ConfigTestHelper {
  static String getPubspecConfig(String resultFileName) {
    print(Directory.current);
    final file = File('config/pubspec_config/$resultFileName.txt');
    return file.readAsStringSync();
  }
}
