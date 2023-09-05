import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/model/model.dart';

class EnumModel extends Model {
  final List<EnumField> fields;
  final List<EnumProperty> properties;

  EnumModel({
    required String name,
    required this.fields,
    required this.properties,
    String? path,
    String? baseDirectory,
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
  final String serializedName;
  final List<EnumValue> values;

  EnumField._({
    required this.name,
    required this.serializedName,
    required this.values,
  });

  factory EnumField({
    required String name,
    required String rawName,
    required List<EnumValue> values,
  }) =>
      EnumField._(
        name: name,
        serializedName: rawName,
        values: values,
      );
}

class EnumProperty {
  final bool isJsonKey;
  final String name;
  ItemType type;

  EnumProperty({
    required this.name,
    required this.type,
    this.isJsonKey = false,
  });
}

class EnumValue {
  final String value;
  final String propertyName;

  EnumValue({
    required this.value,
    required this.propertyName,
  });
}
