import 'package:recase/recase.dart';

import 'field.dart';

class Model {
  final String fileName;
  final String name;
  final List<Field> fields;

  Model._(this.name, this.fileName, this.fields);

  factory Model(String name, List<Field> fields) {
    final fileName = ReCase(name).snakeCase;
    return Model._(name, fileName, fields);
  }

  @override
  String toString() {
    return 'Model{name: $name, fields: $fields}';
  }
}
