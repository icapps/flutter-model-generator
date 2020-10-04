import '../../util/case_util.dart';

abstract class Model {
  final String fileName;

  //nullable
  final String baseDirectory;

  //nullable
  final String path;
  final String name;

  Model(
    this.name,
    String path,
    String baseDirectory,
  )   : path = getPath(path),
        baseDirectory = getBaseDirectory(baseDirectory),
        fileName = getFileName(name);

  static String getPath(String path) {
    if (path != null && path.endsWith('/')) {
      return path.substring(0, path.length - 1);
    }
    return path;
  }

  static getBaseDirectory(String baseDirectory) {
    if (baseDirectory != null && baseDirectory.endsWith('/')) {
      return baseDirectory.substring(0, baseDirectory.length - 1);
    }
    return baseDirectory;
  }

  static String getFileName(String name) => CaseUtil(name).snakeCase;
}
