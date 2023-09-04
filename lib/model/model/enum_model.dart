import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/model/model.dart';

class EnumModel extends Model {
  final List<EnumField>? fields;
  final String keyProperty;

  EnumModel({
    required String name,
    required this.keyProperty,
    String? path,
    String? baseDirectory,
    this.fields,
    List<String>? extraImports,
    List<String>? extraAnnotations,
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
  final List<EnumProperty> enumProperties;
  final String serializedName;

  EnumField._({
    required this.name,
    required this.serializedName,
    required this.enumProperties,
  });

  factory EnumField({
    required String name,
    required List<EnumProperty> enumProperties,
    required String rawName,
  }) =>
      EnumField._(
        name: name,
        enumProperties: enumProperties,
        serializedName: rawName,
      );
}

class EnumProperty {
  final String value;
  final String name;
  final ItemType type;

  EnumProperty({
    required this.value,
    required this.name,
  }) : type = IntegerType();
}
