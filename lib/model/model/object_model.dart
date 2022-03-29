import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/model/model.dart';

class ObjectModel extends Model {
  final bool generateForGenerics;
  final List<Field> fields;
  final List<String> converters;
  final bool? equalsAndHashCode;
  final bool? explicitToJson;
  final bool? generateToString;
  final bool? staticCreate;
  final bool? disallowNullForDefaults;

  ObjectModel({
    required String name,
    required String? path,
    required String? baseDirectory,
    required this.generateForGenerics,
    required this.fields,
    required this.converters,
    List<String>? extraImports,
    List<String>? extraAnnotations,
    String? extendsModel,
    this.equalsAndHashCode,
    this.explicitToJson,
    this.generateToString,
    this.staticCreate,
    this.disallowNullForDefaults,
    String? description,
  }) : super(
          name: name,
          path: path,
          extendsModel: extendsModel,
          baseDirectory: baseDirectory,
          extraAnnotations: extraAnnotations,
          extraImports: extraImports,
          description: description,
        );
}
