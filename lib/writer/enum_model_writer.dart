import '../model/model/enum_model.dart';

class EnumModelWriter {
  final EnumModel jsonModel;

  const EnumModelWriter(this.jsonModel);

  String write() {
    final sb = StringBuffer()
      ..writeln("import 'package:json_annotation/json_annotation.dart';")
      ..writeln()
      ..writeln('enum ${jsonModel.name} {');
    jsonModel.fields.forEach((key) {
      if (key.value == null || key.value.isEmpty) {
        sb
          ..writeln("  @JsonValue('${key.name}')")
          ..writeln('  ${key.serializedName},');
      } else {
        sb
          ..writeln("  @JsonValue('${key.value}')")
          ..writeln('  ${key.serializedName},');
      }
    });
    sb.writeln('}');
    return sb.toString();
  }
}
