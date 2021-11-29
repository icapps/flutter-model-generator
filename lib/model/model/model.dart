import 'package:model_generator/util/case_util.dart';

abstract class Model {
  final String fileName;
  final String? baseDirectory;
  final String? path;
  final String? extendsModel;
  final String name;
  final List<String>? extraImports;
  final List<String>? extraAnnotations;
  final String? description;

  Model({
    required this.name,
    required String? path,
    required String? baseDirectory,
    required this.extraImports,
    required this.extraAnnotations,
    this.extendsModel,
    this.description,
  })  : path = getPath(path),
        baseDirectory = getBaseDirectory(baseDirectory),
        fileName = getFileName(name);

  static String? getPath(String? path) {
    if (path != null && path.endsWith('/')) {
      return path.substring(0, path.length - 1);
    }
    return path;
  }

  static String? getBaseDirectory(String? baseDirectory) {
    if (baseDirectory != null && baseDirectory.endsWith('/')) {
      return baseDirectory.substring(0, baseDirectory.length - 1);
    }
    return baseDirectory;
  }

  static String getFileName(String name) => CaseUtil(name).snakeCase;
}
