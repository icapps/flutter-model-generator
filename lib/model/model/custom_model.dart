import 'package:model_generator/model/model/model.dart';

class CustomModel extends Model {
  CustomModel({
    required String name,
    required String? path,
    required String? baseDirectory,
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
