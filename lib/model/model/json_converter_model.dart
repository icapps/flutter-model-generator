import 'package:model_generator/model/model/model.dart';

class JsonConverterModel extends Model {
  JsonConverterModel({
    required String name,
    String? path,
    String? baseDirectory,
    String? extend,
    List<String>? extraImports,
    List<String>? extraAnnotations,
  }) : super(
          name: name,
          path: path,
          extend: extend,
          baseDirectory: baseDirectory,
          extraAnnotations: extraAnnotations,
          extraImports: extraImports,
        );
}
