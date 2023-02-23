import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/model.dart';

class EnumModel extends Model {
  final List<EnumField>? fields;
  final ItemType itemType;
  final bool generateMap;
  final bool generateExtensions;

  EnumModel({
    required String name,
    String? path,
    String? baseDirectory,
    this.fields,
    this.itemType = const StringType(),
    List<String>? extraImports,
    List<String>? extraAnnotations,
    this.generateMap = false,
    this.generateExtensions = false,
    String? description,
  }) : super(
          name: name,
          path: path,
          baseDirectory: baseDirectory,
          extraImports: extraImports,
          extraAnnotations: extraAnnotations,
          description: description,
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
