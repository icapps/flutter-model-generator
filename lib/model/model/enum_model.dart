import 'package:meta/meta.dart';
import 'package:model_generator/model/model/model.dart';

class EnumModel extends Model {
  final List<EnumField> fields;

  EnumModel({
    String name,
    String path,
    String baseDirectory,
    this.fields,
  }) : super(name: name, path: path, baseDirectory: baseDirectory);
}

class EnumField {
  final String name;
  final String serializedName;
  final String value;

  EnumField._({
    @required this.name,
    @required this.serializedName,
    @required this.value,
  });

  factory EnumField({
    @required String name,
    @required String value,
  }) =>
      EnumField._(
        name: name,
        serializedName: name.toUpperCase(),
        value: value,
      );
}
