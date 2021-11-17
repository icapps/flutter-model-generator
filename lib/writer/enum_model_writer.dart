import 'package:model_generator/model/model/enum_model.dart';

class EnumModelWriter {
  final EnumModel jsonModel;

  const EnumModelWriter(this.jsonModel);

  String write() {
    final sb = StringBuffer()
      ..writeln("import 'package:json_annotation/json_annotation.dart';")
      ..writeln()
      ..writeln('enum ${jsonModel.name} {');
    jsonModel.fields?.forEach((key) {
      final jsonValue = key.value == null || key.value?.isEmpty == null
          ? key.serializedName
          : key.value;
      final description = key.description;
      if (description != null) {
        sb.writeln('  ///$description');
      }
      sb
        ..writeln("  @JsonValue('$jsonValue')")
        ..writeln('  ${key.name},');
    });
    sb.writeln('}');

    if (jsonModel.generateMap) {
      sb
        ..writeln()
        ..writeln('const ${jsonModel.name}Mapping = {');

      jsonModel.fields?.forEach((key) {
        final jsonValue = key.value == null || key.value?.isEmpty == null
            ? key.serializedName
            : key.value;
        sb
          ..write('  ${jsonModel.name}.${key.name}: ')
          ..writeln('\'$jsonValue\',');
      });

      sb
        ..writeln('};')
        ..writeln()
        ..writeln('const reverse${jsonModel.name}Mapping = {');

      jsonModel.fields?.forEach((key) {
        final jsonValue = key.value == null || key.value?.isEmpty == null
            ? key.serializedName
            : key.value;
        sb
          ..write('  \'$jsonValue\': ')
          ..writeln('${jsonModel.name}.${key.name},');
      });

      sb.writeln('};');

      if (jsonModel.generateExtensions) {
        sb
          ..writeln()
          ..writeln(
              'extension ${jsonModel.name}Extension on ${jsonModel.name} {')
          ..writeln(
              '  String get stringValue => ${jsonModel.name}Mapping[this]!;')
          ..writeln('}')
          ..writeln()
          ..writeln('extension ${jsonModel.name}StringExtension on String {')
          ..writeln(
              '  ${jsonModel.name}? get as${jsonModel.name} => reverse${jsonModel.name}Mapping[this];')
          ..writeln('}');
      }
    }

    return sb.toString();
  }
}
