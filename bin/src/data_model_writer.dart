import 'package:recase/recase.dart';

import 'model/item_type/array_type.dart';
import 'model/model.dart';
import 'util/type_checker.dart';

class DataModelWriter {
  final String projectName;
  final Model jsonModel;

  const DataModelWriter(this.projectName, this.jsonModel);

  String write() {
    final sb = StringBuffer()
      ..writeln("import 'package:json_annotation/json_annotation.dart';");
    jsonModel.fields.forEach((field) {
      if (!TypeChecker.isKnownDartType(field.type.name)) {
        final reCaseFieldName = ReCase(field.type.name);
        sb.writeln(
            "import 'package:$projectName/model/${reCaseFieldName.snakeCase}.dart';");
      }
    });

    sb
      ..writeln()
      ..writeln("part '${jsonModel.fileName}.g.dart';")
      ..writeln()
      ..writeln('@JsonSerializable(nullable: false)')
      ..writeln('class ${jsonModel.name} {');

    jsonModel.fields.forEach((key) {
      sb.write("  @JsonKey(name: '${key.name}'");
      if (key.required) {
        sb.write(', required: true');
      }
      sb.writeln(')');
      if (key.type is ArrayType) {
        sb.writeln('  final List<${key.type.name}> ${key.name};');
      } else {
        sb.writeln('  final ${key.type.name} ${key.name};');
      }
    });

    sb..writeln()..writeln('  ${jsonModel.name}(');

    jsonModel.fields.forEach((key) {
      sb.writeln('    this.${key.name},');
    });
    sb
      ..writeln('  );')
      ..writeln()
      ..writeln(
          '  factory ${jsonModel.name}.fromJson(Map<String, dynamic> json) => _\$${jsonModel.name}FromJson(json);')
      ..writeln()
      ..writeln(
          '  Map<String, dynamic> toJson() => _\$${jsonModel.name}ToJson(this);')
      ..writeln()
      ..writeln('}');
    return sb.toString();
  }
}
