import 'package:model_generator/model/model/model.dart';

class JsonConverterModel extends Model {
  JsonConverterModel({
    required String name,
    String? path,
    String? baseDirectory,
  }) : super(name: name, path: path, baseDirectory: baseDirectory);
}
