import 'package:model_generator/model/item_type/double_type.dart';
import 'package:model_generator/model/item_type/string_type.dart';
import 'package:model_generator/model/model/enum_model.dart';
import 'package:model_generator/util/case_util.dart';
import 'package:model_generator/util/list_extensions.dart';
import 'package:model_generator/writer/object_model_writer.dart';

class EnumModelWriter {
  final EnumModel jsonModel;

  const EnumModelWriter(this.jsonModel);

  String write() {
    final sb = StringBuffer()
      ..writeln(ObjectModelWriter.autoGeneratedWarning)
      ..writeln()
      ..writeln("import 'package:json_annotation/json_annotation.dart';")
      ..writeln();

    final modelDescription = jsonModel.description?.trim();
    if (modelDescription != null && modelDescription.isNotEmpty) {
      sb.writeln("///$modelDescription");
    }

    final jsonModelName = CaseUtil(jsonModel.name);
    final properties = jsonModel.properties;
    final keyProperty =
        properties.firstWhereOrNull((property) => property.isJsonvalue);
    final addDefaultJsonKey =
        keyProperty == null && jsonModel.addJsonKeyToProperties;
    final addProperties = properties.isNotEmpty || addDefaultJsonKey;

    sb.writeln('enum ${jsonModelName.pascalCase} {');
    for (var key in jsonModel.fields) {
      final jsonValue = key.values
              .firstWhereOrNull(
                  (value) => value.propertyName == keyProperty?.name)
              ?.value ??
          key.serializedName;
      final propertyType = keyProperty?.type;
      final isLast =
          jsonModel.fields.indexOf(key) == (jsonModel.fields.length - 1);

      if (key.description != null) {
        sb.writeln('  ///${key.description}');
      }
      if (propertyType is StringType || propertyType == null) {
        sb.writeln('  @JsonValue(\'$jsonValue\')');
      } else if (propertyType is DoubleType) {
        final doubleValue = double.tryParse(jsonValue);
        sb.writeln('  @JsonValue($doubleValue)');
      } else {
        sb.writeln('  @JsonValue($jsonValue)');
      }
      sb.write('  ${key.name}');

      if (addProperties) {
        sb.writeln('(');
        if (addDefaultJsonKey) {
          sb.writeln('    jsonValue: \'$jsonValue\',');
        }
        for (var property in properties) {
          final enumValue = valueForProperty(property.name, key.values);
          var value = enumValue?.value ?? property.defaultValue;

          sb.write('    ${property.name}: ');
          if (property.type is StringType &&
              (value != null || property.isJsonvalue)) {
            if (value == null && property.isJsonvalue) value = jsonValue;
            sb.writeln('\'$value\',');
          } else {
            sb.writeln('$value,');
          }
        }
        if (isLast) {
          sb.writeln('  );');
        } else {
          sb.writeln('  ),');
        }
      } else {
        sb.writeln(',');
      }
    }

    if (addProperties) {
      sb.writeln();
    }

    if (addDefaultJsonKey) {
      sb.writeln('  final String jsonValue;');
    }
    for (var property in properties) {
      sb.write('  final ${property.type.name}');
      if (property.isOptional) {
        sb.write('?');
      }
      sb.writeln(' ${property.name};');
    }
    if (addProperties) {
      sb.writeln();
      sb.writeln('  const ${jsonModelName.pascalCase}({');
      if (addDefaultJsonKey) {
        sb.writeln('    required this.jsonValue,');
      }
      for (var property in properties) {
        sb.write('    ');
        if (!property.isOptional) {
          sb.write('required ');
        }
        sb.writeln('this.${property.name},');
      }
      sb.writeln('  });');
    }

    sb.writeln('}');

    return sb.toString();
  }

  EnumValue? valueForProperty(
    String propertyName,
    List<EnumValue> values,
  ) =>
      values.firstWhereOrNull((value) => value.propertyName == propertyName);
}
