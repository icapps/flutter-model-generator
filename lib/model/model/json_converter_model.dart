import 'package:model_generator/model/model/model.dart';

class JsonConverterModel extends Model {
  JsonConverterModel({
    required String name,
    String? path,
    String? baseDirectory,
    List<String>? extraImports,
    List<String>? extraAnnotations,
  }) : super(
          name: name,
          path: path,
          baseDirectory: baseDirectory,
          extraAnnotations: extraAnnotations,
          extraImports: extraImports,
        );
}
