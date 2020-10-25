import 'dart:io';

class ConfigTestHelper {
  static String getPubspecConfig(String resultFileName) {
    print(Directory.current);
    final file = File('writer/pubspec_config/$resultFileName.txt');
    return file.readAsStringSync();
  }
}
