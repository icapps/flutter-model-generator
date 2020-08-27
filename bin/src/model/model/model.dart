import '../../util/case_util.dart';

abstract class Model {
  final String fileName;

  //nullable
  final String path;
  final String name;
  final String modelDirectory;

  Model(
    this.name,
    String path,
    {String modelDirectory = 'model'}
  )   : path = getPath(path),
        modelDirectory = getPath(modelDirectory),
        fileName = getFileName(name);

  static String getPath(String path) {
    if (path != null && path.endsWith('/')) {
      return path.substring(0, path.length - 1);
    }
    return path;
  }

  static String getFileName(String name) => CaseUtil(name).snakeCase;
}
