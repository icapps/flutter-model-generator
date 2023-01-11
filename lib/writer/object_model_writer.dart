import 'package:model_generator/config/pubspec_config.dart';
import 'package:model_generator/config/yml_generator_config.dart';
import 'package:model_generator/model/field.dart';
import 'package:model_generator/model/model/custom_from_to_json_model.dart';
import 'package:model_generator/model/model/object_model.dart';
import 'package:model_generator/util/field_util.dart';
import 'package:model_generator/util/model_helper.dart';

class ObjectModelWriter {
  final PubspecConfig pubspecConfig;
  final ObjectModel jsonModel;
  final YmlGeneratorConfig yamlConfig;

  const ObjectModelWriter(
    this.pubspecConfig,
    this.jsonModel,
    this.yamlConfig,
  );

  String write() {
    final extendsFields = FieldUtil.getExtendedFields(jsonModel, yamlConfig);
    final sb = StringBuffer();
    final fields =
        jsonModel.fields.where((element) => !element.onlyForTable).toList();

    ModelHelper.writeImports(
      initialImports: {}
        ..add("import 'package:json_annotation/json_annotation.dart';"),
      jsonModel: jsonModel,
      pubspecConfig: pubspecConfig,
      yamlConfig: yamlConfig,
      extendsFields: extendsFields,
      sb: sb,
    );
    final extendsModel = jsonModel.extendsModel;

    sb
      ..writeln("part '${jsonModel.fileName}.g.dart';")
      ..writeln();

    final modelDescription = jsonModel.description?.trim();
    if (modelDescription != null && modelDescription.isNotEmpty) {
      sb.writeln("///$modelDescription");
    }

    if (jsonModel.explicitToJson ?? pubspecConfig.explicitToJson) {
      sb.writeln('@JsonSerializable(explicitToJson: true)');
    } else {
      sb.writeln('@JsonSerializable()');
    }
    (jsonModel.extraAnnotations ?? pubspecConfig.extraAnnotations)
        .forEach(sb.writeln);

    for (final converter in jsonModel.converters) {
      sb.writeln('@$converter()');
    }

    if (extendsModel != null) {
      sb.writeln('class ${jsonModel.name} extends $extendsModel {');
    } else {
      sb.writeln('class ${jsonModel.name} {');
    }

    fields.sort((a, b) {
      final b1 = a.isRequired ? 1 : 0;
      final b2 = b.isRequired ? 1 : 0;
      return b2 - b1;
    });

    for (final key in fields) {
      final description = key.description;
      if (description != null) {
        sb.writeln('  ///$description');
      }
      sb.write("  @JsonKey(name: '${key.serializedName}'");
      if (key.isRequired) {
        if (key.hasDefaultValue) {
          sb.write(', required: false, disallowNullValue: ${key.disallowNull}');
        } else {
          sb.write(', required: true');
        }
      }

      if (!key.includeIfNull) {
        sb.write(', includeIfNull: false');
      }

      if (key.ignore) {
        sb.write(', ignore: true');
      }

      if (key.unknownEnumValue != null) {
        sb.write(
            ', unknownEnumValue: ${key.type.name}.${key.unknownEnumValue}');
      }

      final fieldModel = yamlConfig.getModelByName(key.type);
      if (key.fromJson != null) {
        sb.write(', fromJson: ${key.fromJson}');
      } else if (fieldModel is CustomFromToJsonModel) {
        sb.write(', fromJson: handle${fieldModel.name}FromJson');
      }
      if (key.toJson != null) {
        sb.write(', toJson: ${key.toJson}');
      } else if (fieldModel is CustomFromToJsonModel) {
        sb.write(', toJson: handle${fieldModel.name}ToJson');
      }
      sb.writeln(')');
      if (key.nonFinal) {
        sb.write('  ');
      } else {
        sb.write('  final ');
      }
      sb.writeln('${ModelHelper.getKeyType(key)} ${key.name};');
    }

    final anyNonFinal = fields.any((element) => element.nonFinal) ||
        extendsFields.any((element) => element.nonFinal);
    sb
      ..writeln()
      ..writeln('  ${anyNonFinal ? '' : 'const '}${jsonModel.name}({');

    for (final key
        in fields.where((key) => (key.isRequired && !key.hasDefaultValue))) {
      sb.writeln('    required this.${key.name}${_fillDefaulValue(key)},');
    }
    for (final key in extendsFields
        .where((key) => (key.isRequired && !key.hasDefaultValue))) {
      sb.writeln(
          '    required ${ModelHelper.getKeyType(key)} ${key.name}${_fillDefaulValue(key)},');
    }
    for (final key
        in fields.where((key) => !(key.isRequired && !key.hasDefaultValue))) {
      sb.writeln('    this.${key.name}${_fillDefaulValue(key)},');
    }
    for (final key in extendsFields
        .where((key) => !(key.isRequired && !key.hasDefaultValue))) {
      sb.writeln(
          '    ${ModelHelper.getKeyType(key)} ${key.name}${_fillDefaulValue(key)},');
    }
    if (extendsModel != null) {
      sb.writeln('  }) : super(');
      for (final key in extendsFields) {
        sb.writeln('          ${key.name}: ${key.name},');
      }
      sb
        ..writeln('        );')
        ..writeln();
    } else {
      sb
        ..writeln('  });')
        ..writeln();
    }
    if (jsonModel.generateForGenerics) {
      sb.writeln(
          '  factory ${jsonModel.name}.fromJson(Object? json) => _\$${jsonModel.name}FromJson(json as Map<String, dynamic>); // ignore: avoid_as');
    } else {
      sb.writeln(
          '  factory ${jsonModel.name}.fromJson(Map<String, dynamic> json) => _\$${jsonModel.name}FromJson(json);');
    }
    sb.writeln();
    if (extendsModel != null) {
      sb.writeln('  @override');
    }
    sb.writeln(
        '  Map<String, dynamic> toJson() => _\$${jsonModel.name}ToJson(this);');

    if (jsonModel.staticCreate ?? pubspecConfig.staticCreate) {
      sb
        ..writeln()
        ..writeln('  // ignore: prefer_constructors_over_static_methods')
        ..writeln(
            '  static ${jsonModel.name} create(${jsonModel.generateForGenerics ? 'Object? json' : 'Map<String, dynamic> json'}) => ${jsonModel.name}.fromJson(json);');
    }

    if (jsonModel.equalsAndHashCode ?? pubspecConfig.equalsHashCode) {
      sb
        ..writeln()
        ..writeln('  @override')
        ..writeln('  bool operator ==(Object other) =>')
        ..writeln('      identical(this, other) ||')
        ..writeln('      other is ${jsonModel.name} &&')
        ..write('          runtimeType == other.runtimeType');
      for (final field in fields.where((field) => !field.ignoreEquality)) {
        sb.write(' &&\n          ${field.name} == other.${field.name}');
      }
      if (extendsModel != null) {
        sb.write(' &&\n          super == other');
      }
      sb
        ..writeln(';')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  int get hashCode =>');
      var c = 0;
      for (final field in fields.where((field) => !field.ignoreEquality)) {
        if (c++ > 0) sb.write(' ^\n');
        sb.write('      ${field.name}.hashCode');
      }
      if (extendsModel != null) {
        sb.write(' ^ \n      super.hashCode');
      }
      if (c == 0) sb.write('      0');
      sb.writeln(';');
    }
    if (jsonModel.generateToString ?? pubspecConfig.generateToString) {
      sb
        ..writeln()
        ..writeln('  @override')
        ..writeln('  String toString() =>')
        ..writeln('      \'${jsonModel.name}{\'');

      var c = 0;
      for (final field in fields) {
        if (c++ > 0) sb.writeln(', \'');
        sb.write('      \'${field.name}: \$${field.name}');
      }
      for (final field in extendsFields) {
        if (c++ > 0) sb.writeln(', \'');
        sb.write('      \'${field.name}: \$${field.name}');
      }
      sb.writeln('\'\n      \'}\';');
    }

    sb
      ..writeln()
      ..writeln('}');

    if (pubspecConfig.retrofitMappers) {
      createRetrofitMappers(sb);
    }

    return sb.toString();
  }

  String _fillDefaulValue(Field key) {
    if (key.hasDefaultValue) {
      return ' = ${key.defaultValue}';
    } else {
      return '';
    }
  }

  void createRetrofitMappers(StringBuffer sb) {
    final hasConstructorTearOffs =
        pubspecConfig.languageVersion?.isAtLeast(2, 15) ?? false;
    sb
      ..writeln()
      ..writeln(hasConstructorTearOffs
          ? 'const deserialize${jsonModel.name} = ${jsonModel.name}.fromJson;'
          : '${jsonModel.name} deserialize${jsonModel.name}(Map<String, dynamic> json) => ${jsonModel.name}.fromJson(json);')
      ..writeln()
      ..writeln(
          'Map<String, dynamic> serialize${jsonModel.name}(${jsonModel.name} object) => object.toJson();')
      ..writeln()
      ..writeln(
          'List<${jsonModel.name}> deserialize${jsonModel.name}List(List<Map<String, dynamic>> jsonList)')
      ..writeln(hasConstructorTearOffs
          ? '    => jsonList.map(${jsonModel.name}.fromJson).toList();'
          : '    => jsonList.map((json) => ${jsonModel.name}.fromJson(json)).toList();')
      ..writeln()
      ..writeln(
          'List<Map<String, dynamic>> serialize${jsonModel.name}List(List<${jsonModel.name}> objects)')
      ..writeln('    => objects.map((object) => object.toJson()).toList();');
  }
}
