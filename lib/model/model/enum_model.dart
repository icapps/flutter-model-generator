import 'package:model_generator/model/model/model.dart';

class EnumModel extends Model {
  final List<EnumField>? fields;
  final bool generateMap;

  EnumModel({
    required String name,
    String? path,
    String? baseDirectory,
    this.fields,
    List<String>? extraImports,
    List<String>? extraAnnotations,
    this.generateMap = false,
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

  EnumField._({
    required this.name,
    required this.serializedName,
    required this.value,
  });

  factory EnumField({
    required String name,
    String? value,
  }) =>
      EnumField._(
        name: name.toUpperCase(),
        serializedName: name,
        value: value,
      );
}
