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
      sb..writeln("  @JsonValue('$jsonValue')")..writeln('  ${key.name},');
    });
    sb.writeln('}');
    return sb.toString();
  }
}
