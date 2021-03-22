import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/model/model.dart';

class ObjectModel extends Model {
  final bool generateForGenerics;
  final List<Field> fields;
  final List<String> converters;

  ObjectModel({
    required String name,
    required String? path,
    required String? baseDirectory,
    required this.generateForGenerics,
    required this.fields,
    required this.converters,
  }) : super(name: name, path: path, baseDirectory: baseDirectory);
}
