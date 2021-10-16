import 'package:model_generator/model/model/model.dart';

class EnumModel extends Model {
  final List<EnumField>? fields;
  final bool generateMap;
  final bool generateExtensions;

  EnumModel({
    required String name,
    String? path,
    String? baseDirectory,
    this.fields,
    List<String>? extraImports,
    List<String>? extraAnnotations,
    this.generateMap = false,
    this.generateExtensions = false,
  }) : super(
          name: name,
          path: path,
          baseDirectory: baseDirectory,
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
        );
}

class EnumField {
  final String name;
  final String serializedName;
  final String? value;
  final String? description;

  EnumField._({
    required this.name,
    required this.serializedName,
    required this.value,
    required this.description,
  });

  factory EnumField({
    required String name,
    required String rawName,
    String? value,
    String? description,
  }) =>
      EnumField._(
        name: name,
        serializedName: rawName,
        value: value,
        description: description,
      );
}
