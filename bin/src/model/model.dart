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
    return Model._(name, path, fileName, fields);
  }

  @override
  String toString() {
    return 'Model{name: $name, fields: $fields}';
  }
}
