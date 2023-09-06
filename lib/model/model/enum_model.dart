import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/model/model.dart';

class EnumModel extends Model {
  final List<EnumField> fields;
  final List<EnumProperty> properties;
  final bool addJsonKeyToProperties;

  EnumModel({
    required String name,
    required this.fields,
    required this.properties,
    this.addJsonKeyToProperties = true,
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
  final String? description;
  final List<EnumValue> values;

  EnumField._({
    required this.name,
    required this.serializedName,
    required this.values,
    this.description,
  });

  factory EnumField({
    required String name,
    required String rawName,
    required List<EnumValue> values,
    String? description,
  }) =>
      EnumField._(
        name: name,
        serializedName: rawName,
        values: values,
        description: description,
      );
}

class EnumProperty {
  final bool isJsonKey;
  final bool isOptional;
  final String name;
  String? defaultValue;
  ItemType type;

  EnumProperty({
    required this.name,
    required this.type,
    required this.isOptional,
    this.defaultValue,
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
