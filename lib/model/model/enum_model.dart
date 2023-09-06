import 'package:model_generator/model/item_type/boolean_type.dart';
import 'package:model_generator/model/item_type/double_type.dart';
import 'package:model_generator/model/item_type/integer_type.dart';
import 'package:model_generator/model/item_type/item_type.dart';
import 'package:model_generator/model/model/model.dart';
import 'package:model_generator/util/list_extensions.dart';

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

  String? validate() {
    for (final property in properties) {
      for (final field in fields) {
        final value = field.values.firstWhereOrNull((value) => value.propertyName == property.name)?.value;
        if (value == null && !property.isOptional && property.defaultValue == null) {
          return 'There is no value defined for property ${property.name} for the enum value ${field.name} in model $name. Either make this property optional or give it a value';
        }
        final toParseValue = value ?? property.defaultValue;
        if (property.type is DoubleType) {
          return testValueType(
            parser: double.tryParse,
            typeName: DoubleType().name,
            toParseValue: toParseValue!,
            propertyName: property.name,
            fieldName: field.name,
          );
        } else if (property.type is IntegerType) {
          return testValueType(
            parser: int.tryParse,
            typeName: IntegerType().name,
            toParseValue: toParseValue!,
            propertyName: property.name,
            fieldName: field.name,
          );
        } else if (property.type is BooleanType) {
          return testValueType(
            parser: bool.tryParse,
            typeName: BooleanType().name,
            toParseValue: toParseValue!,
            propertyName: property.name,
            fieldName: field.name,
          );
        }
      }
    }
    return null;
  }

  String? testValueType<T>({
    required T? Function(String toParseValue) parser,
    required String typeName,
    required String toParseValue,
    required String propertyName,
    required String fieldName,
  }) {
    final result = parser(toParseValue);
    if (result == null) {
      return 'Model: $name, Property $propertyName is of type $typeName but the corresponding value on enum value $fieldName is not, make sure they have the same type';
    }
    return null;
  }
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
