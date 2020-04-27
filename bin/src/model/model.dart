import 'package:recase/recase.dart';

import 'field.dart';

class Model {
  final String fileName;

  //nullable
  final String path;
  final String name;
  final List<Field> fields;

  Model._(this.name, this.path, this.fileName, this.fields);

  factory Model(String name, String path, List<Field> fields) {
    final fileName = ReCase(name).snakeCase;
    if (path != null && path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    return Model._(name, path, fileName, fields);
  }
}
