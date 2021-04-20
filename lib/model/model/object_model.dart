import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/model/model.dart';

class ObjectModel extends Model {
  final bool generateForGenerics;
  final List<Field> fields;
  final List<String> converters;
  final bool? equalsAndHashCode;
  final bool? generateToString;

  ObjectModel({
    required String name,
    required String? path,
    required String? baseDirectory,
    required this.generateForGenerics,
    required this.fields,
    required this.converters,
    List<String>? extraImports,
    List<String>? extraAnnotations,
    this.equalsAndHashCode,
    this.generateToString,
  }) : super(
          name: name,
          path: path,
          baseDirectory: baseDirectory,
          extraAnnotations: extraAnnotations,
          extraImports: extraImports,
        );
}
