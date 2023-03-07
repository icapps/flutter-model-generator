import 'dart:io';

import 'package:meta/meta.dart';
import 'package:model_generator/util/language_version.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

class PubspecConfig {
  static final _DEFAULT_CONFIG_PATH = // ignore: non_constant_identifier_names
      'model_generator${Platform.pathSeparator}config.yaml';
  static const _defaultBaseDirectory = 'model';
  String _defaultDatabaseDirectory(String projectName) => 'database/${projectName}_database.dart';

  late String projectName;
  late String baseDirectory;
  late bool useFvm;
  late bool generateForGenerics;
  late String configPath;
  late String databasePath;
  late bool equalsHashCode;
  late bool explicitToJson;
  late bool generateToString;
  late bool staticCreate;
  late bool uppercaseEnums;
  late bool retrofitMappers;
  late bool disallowNullForDefaults;
  late bool generateInjectableInDaos;
  LanguageVersion? languageVersion;
  final extraImports = <String>[];
  final extraAnnotations = <String>[];

  PubspecConfig(String pubspecContent) {
    final doc = loadYaml(pubspecContent);
    if (doc is! YamlMap) {
      throw Exception('Could not parse the pubspec.yaml');
    }
    final projectName = doc['name'];
    languageVersion = parseLanguageVersion(doc);

    if (projectName == null || projectName.isEmpty) {
      throw Exception('Could not parse the pubspec.yaml, project name not found');
    }

    this.projectName = projectName;
    final config = doc['model_generator'];
    if (config == null) {
      baseDirectory = _defaultBaseDirectory;
      generateForGenerics = false;
      useFvm = false;
      configPath = _DEFAULT_CONFIG_PATH;
      databasePath = '';
      equalsHashCode = false;
      explicitToJson = true;
      generateToString = false;
      staticCreate = false;
      uppercaseEnums = true;
      retrofitMappers = false;
      disallowNullForDefaults = false;
      generateInjectableInDaos = true;
      return;
    }

    baseDirectory = config['base_directory'] ?? _defaultBaseDirectory;
    useFvm = (config['use_fvm'] ?? false) == true;
    generateForGenerics = (config['generate_for_generics'] ?? false) == true;
    configPath = config['config_path'] ?? _DEFAULT_CONFIG_PATH;
    databasePath = config['database_path'] ?? _defaultDatabaseDirectory(projectName);
    equalsHashCode = (config['equals_and_hash_code'] ?? false) == true;
    explicitToJson = (config['explicit_to_json'] ?? true) == true;
    generateToString = (config['to_string'] ?? false) == true;
    staticCreate = (config['static_create'] ?? false) == true;
    uppercaseEnums = (config['uppercase_enums'] ?? true) == true;
    retrofitMappers = (config['retrofit_compute'] ?? false) == true;
    disallowNullForDefaults = (config['disallow_null_for_defaults'] ?? false) == true;
    generateInjectableInDaos = (config['generate_injectable_in_daos'] ?? true) == true;

    final extraImports = config['extra_imports'];
    if (extraImports != null) {
      extraImports.forEach((element) => this.extraImports.add(element.toString()));
    }
    final extraAnnotations = config['extra_annotations'];
    if (extraAnnotations != null) {
      extraAnnotations.forEach((element) => this.extraAnnotations.add(element.toString()));
    }
  }

  @visibleForTesting
  static LanguageVersion? parseLanguageVersion(YamlMap doc) {
    final environmentRoot = doc['environment'];
    if (environmentRoot is! YamlMap) return null;
    final sdk = environmentRoot['sdk'];
    if (sdk is! String) return null;

    final range = VersionConstraint.parse(sdk);
    if (range is Version) {
      return LanguageVersion(range.major, range.minor, range.patch);
    } else if (range is VersionRange) {
      final min = range.min;
      if (min == null) return null;
      return LanguageVersion(min.major, min.minor, min.patch);
    }

    return null;
  }
}
